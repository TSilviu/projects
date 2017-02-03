// COMS20001 - Cellular Automaton Farm
// (using the XMOS i2c accelerometer demo)

#include <platform.h>
#include <xs1.h>
#include <stdio.h>
#include "pgmIO.h"
#include "i2c.h"

#define  IMHT 1220        //image height
#define  IMWD 1220
#define  height1 610    // height1 = max(IMWD,IMHT)/2 - height of the area first distributor works on
#define  height2 610    // height2 = max(IMWD,IMHT) - height1
#define  wid 1220         // wid = min(IMWD,IMHT)
#define  work_size 8    //work_size <= min(IMWD,IMHT)
#define  numberOfThreads1 4
#define  numberOfThreads2 5
#define noOfRounds 1500
#define infname "128x128.pgm"
#define outfname "testout.pgm"
#define transpose 1     // we set if we want to transpose the matrix


typedef unsigned char uchar;      //using uchar as shorthand

on tile[0] : in port buttons = XS1_PORT_4E; //port to access xCore-200 buttons
on tile[0] : out port leds = XS1_PORT_4F;   //port to access xCore-200 LEDs

on tile[0]: port p_scl = XS1_PORT_1E;         //interface ports to accelerometer
on tile[0]: port p_sda = XS1_PORT_1F;

#define FXOS8700EQ_I2C_ADDR 0x1E  //register addresses for accelerometer
#define FXOS8700EQ_XYZ_DATA_CFG_REG 0x0E
#define FXOS8700EQ_CTRL_REG_1 0x2A
#define FXOS8700EQ_DR_STATUS 0x0
#define FXOS8700EQ_OUT_X_MSB 0x1
#define FXOS8700EQ_OUT_X_LSB 0x2
#define FXOS8700EQ_OUT_Y_MSB 0x3
#define FXOS8700EQ_OUT_Y_LSB 0x4
#define FXOS8700EQ_OUT_Z_MSB 0x5
#define FXOS8700EQ_OUT_Z_LSB 0x6

//READ BUTTONS and send button pattern to DataInStream and DataOutStream
void buttonListener(in port b, chanend toDataInStream, chanend toDataOutStream) {
  int r;
  uchar ok = 0;

  while (1) {
    b when pinseq(15)  :> r;    // check that no button is pressed
    b when pinsneq(15) :> r;    // check if some buttons are pressed
    if( r == 14 && ok == 0 ){
       toDataInStream <: 1;
       ok = 1;
    } else {
       if( r == 13 && ok == 1 ){
           toDataOutStream <: 1;
       }
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////
//
// Read Image from PGM file from path infname[] to channel c_out
//
/////////////////////////////////////////////////////////////////////////////////////////
void DataInStream(chanend c_out, chanend fromButtonListener, chanend toDataOutStream)
{
  int res;
  int buttonInput = 0;

  uchar line[ IMWD ];

  printf( "DataInStream: Start...\n" );
  printf( "Waiting for Button press...\n" );

  fromButtonListener :> buttonInput;

  if( buttonInput == 1 ){

      //Open PGM file
      res = _openinpgm( infname, IMWD, IMHT );
      if( res ) {
        printf( "DataInStream: Error openening %s\n.", infname );
        return;
      }

      c_out <: 1;

     //Read image line-by-line and send byte by byte to channel c_out
     for( int y = 0; y < IMHT; y++ ) {
        _readinline( line, IMWD );
        for( int x = 0; x < IMWD; x++ ) {
          c_out <: line[x];
        }
      }

     for( int y = 0; y < IMHT; y++ ) {
             for( int x = 0; x < IMWD; x++ ) {
               c_out <: (uchar) (255);
             }
           }

      //Close PGM image file
      _closeinpgm();
      toDataOutStream <: 1;
  }
  return;
}

///////////////////////////////////////////////////////////////
//
// Worker gets coordinates of the area it is going to work on.
// It sends -1 to distributor if it is ready for more work
// 1 if it wants to send the computed results
//
///////////////////////////////////////////////////////////////
void worker (chanend mast_in)
{

    int run = 1,x1,x2,y1,y2;
    int received;

    while(1){
        while(run)
        {
            //get area to work on from distributor
            mast_in <: -1;
            mast_in :> x1;      // read the area coordinates you will work on
            mast_in :> y1;
            mast_in :> x2;
            mast_in :> y2;

            //check if there is no more job left
            if(x1+x2+y1+y2<0){
                break;
            }

            int answer[work_size+2][(work_size+2)/31+1];
            int T[work_size+2][(work_size+2)/31+1];

            for(int i=0;i<=x2-x1+2;i++){
                for(int j=0;j<=(y2-y1+3)/31;j++)
                    answer[i][j]=0;
            }

            //store the area to work on such that every cell in T is a line in the
            //original area
            for( int y = 0; y <= x2-x1+2; y++){
               int a = 0, b = 0, c = 0,data;
               for( int x = 0; x <= y2-y1+2; x++)
               {
                 mast_in :> data;
                 b *= 2;
                 b+=data;
                 a++;
                 if(a==31)
                 {
                     a = 0;
                     T[y][c] = b;
                     b = 0;
                     c++;
                 }
               }
               T[y][c] = b;
           }

           int width = y2-y1+3, liveness, result;

           //apply the game of life rules on the area the worker is working on
           for( int a=1; a < x2-x1+2; a++ )
           {
                for( int b=1; b <width-1; b++ )
                {
                    // We calculate the cell T[a][b]
                    if(width/31 != b/31) liveness = ((T[a][b/31]/(1<<(30 - b%31)))&1);
                    else liveness = ((T[a][b/31]/(1<<((width-1-b)%31)))&1);
                    int live_cells = 0;
                    for( int i = -1; i < 2 ; i++ )
                    {
                        for( int j = -1; j < 2; j++ )
                        {
                            if(i!=0 || j!=0)
                            {
                               if(width/31 != (b + j)/31)live_cells += ((T[a+i][(b + j)/31]/(1<<(30 - ((b + j)%31))))&1);
                               else live_cells += ((T[a+i][(b + j)/31]/(1<<((width-1-b-j)%31)))&1);
                            }
                        }
                    }
                    if( liveness==1 && (live_cells > 3 || live_cells < 2) ) result = 0;
                    else if (liveness ==0 && live_cells == 3) result = 1;
                    else result = liveness;
                    if(result==1)
                    {
                        if(width/31 != b/31) answer[a][b/31]+=(1<<(30 - b%31));
                        else answer[a][b/31]+=(1<<((width-1-b)%31));
                    }
                }

           }

            //let the distributor know that the worker has finished and send data back
            mast_in <: 1;
            mast_in <: x1;
            mast_in <: y1;
            mast_in <: x2;
            mast_in <: y2;

            for(int a=1;a<x2-x1+2;a++){
                for(int b=1;b<y2-y1+2;b++)
                {
                    if(width/31 != b/31)  mast_in <: ((answer[a][b/31]/(1<<(30 - b%31)))&1);
                    else  mast_in <: ((answer[a][b/31]/(1<<((width-1-b)%31)))&1);
                }
            }
        }
        mast_in :> received;
    }
}

/////////////////////////////////////////////////////////////////////////////////////////
//
// The controller splits the image on two different tiles, sending it to the distributors,
// it also sends the leds pattern and listens for signals from the accelerometer.
//
/////////////////////////////////////////////////////////////////////////////////////////
void controller(out port p, chanend c_in, chanend fromAcc, chanend toDistributor1, chanend toDistributor2){

    uchar value;
    int completedProcessingRounds = 0;
    int done1 = 0;
    int done2 = 0;
    int pattern;
    int tilted = 0;

    unsigned long time1, time2, a, b, total = 0;

    //send to leds tht reading has started
    c_in :> pattern;

    //light up the green led
    p <: 4;

    //We check if it convenient to transpose the image and then we read cells
    if(IMHT>=IMWD || transpose==0)
    {
        for(int i = 1; i <= IMHT; i++){
            for(int j = 1; j <= IMWD; j++){
                c_in :> value;
                if( i <= height1 + 1 || i == IMHT ){
                    toDistributor1 <: value;
                }
                if( i == 1 || i >= height1){
                    toDistributor2 <: value;
                }
            }
        }
    }
    else
    {
        for(int i=1;i<=IMHT;i++)
        {
             for(int j=1;j<=IMWD;j++)
             {
                c_in :>value;

                if(j<=height1+1 || j==IMWD)
                {
                    toDistributor1 <: value;
                }
                if(j==1 || j>=height1) toDistributor2 <: value;
             }
         }
    }

    timer t;

    while(1){

       t :> time1;

       //check if the time value is too big to store in variable time1
       if( time1 < b ){
           a = (4294967295 - b) + time1;
       } else {
           a = time1;
       }

        //get data from accelerometer
       fromAcc :> tilted;

       while( tilted == 1 ){    //if the data is 1 than board has been tilted
           fromAcc :> tilted;
            p <: 8;             //light up the red led
       }

        //check if both distributors finished an iteration
        toDistributor1 :> done1;
        toDistributor2 :> done2;

        //check if the distributor 1 is in the sequence where it sends output data
        if( done1 == 1 ){
            p <: 2;         //light up the blue led
            toDistributor2 :> done2;
        }

        p <: 5;                 //light up the separate green led

        completedProcessingRounds++;

        t :> time2;

        if( time2 < a ){
            b = (4294967295 - a) + time2;
        } else {
            b = time2;
        }

        total = total + (b - a)/10000;

        printf("\nProcessed round no. %d\n", completedProcessingRounds);

        if( completedProcessingRounds == noOfRounds - 1 ){

            printf("%lu\n", total);
        }

        p <: 4;
   }
}

/////////////////////////////////////////////////////////////////////////////////////////
//
// Distributor 1 keeps the data for the first half of the image, compressing it by
// storring it in a bit array. It also sends information from to the workers, receives
// information from the workers and sends the first half th dataOutStream when button is
// pressed.
//
/////////////////////////////////////////////////////////////////////////////////////////
void distributor1(chanend fromController, chanend work[numberOfThreads1], chanend c_out, chanend toDistributor2){

    uchar val;

    unsigned int T[height1 + 2][wid/31 + 1];    //the compressed array
    unsigned int ans[height1 + 2][wid/31 + 1];  //the answer array that keeps the result after each computation

    int finishedThreads = 0;
    int firstRound = 0;
    int rounds = 0;
    int signal;

    while(rounds<noOfRounds){            //check if the rounds are over

        for( int i = 0; i<height1+2; i++){
           for( int j = 0; j < wid/31 + 1; j++){
               ans[i][j] = 0;
           }
        }

        finishedThreads = 0;            //start all the threads again

        if( firstRound == 0 ){          //check if the first round has passed
            for( int i = 0; i<height1+2; i++){
               for( int j = 0; j < wid/31 + 1; j++){
                   T[i][j] = 0;
               }
            }
            //read the input matrix and do the transpose if necessary
            if(IMHT>=IMWD || transpose==0)
            {
                for( int y = 1; y <= height1 + 2; y++ )
                {   //go through all lines and convert them into an integer representation
                    int a = 0, b = 0, c = 0;
                    if( y == height1 + 2){
                        y = 0;
                    }
                    for( int x = 1; x <= IMWD; x++ ) { //go through each pixel per line
                      fromController :> val;   //read the pixel value
                      b *= 2;
                      if(val != 0) b++;
                      a++;
                      if(a==31)             //check if the line is bigger that 32
                      {
                          a = 0;
                          T[y][c] = b;
                          b = 0;
                          c++;              //add another column to the bit array
                      }
                    }
                    T[y][c] = b;
                    if( y == 0 ){
                        break;
                    }
                }
            }
            else
            {
                //reading one half of transpose of input image
                for(int i=0; i<IMHT;i++)
                {
                    for(int j=1;j<=height1+2;j++)
                    {
                        if(j==height1 + 2) j=0;
                        fromController :> val;
                        T[j][i/31]*=2;
                        if(val!=0)T[j][i/31]++;
                        if(j==0)break;
                    }
                }
            }
        }

        int x1=1, x2= work_size, y1=0, y2=work_size-1;  //coordinates of the NEXT area to send to workers
        //checks if all the threads are finished for the current iteration
        while(finishedThreads < numberOfThreads1){
            select{
                case work [int j] :> int data:  //check if worker thread asked for data
                    //Here we check if we can skip some uninteresting all-white or all-black parts
                    if(data == -1)
                    {
                        int cnt[2];
                        cnt[0] = 0;
                        cnt[1] = 0;
                        while(cnt[0]*cnt[1]==0 && x1 <= height1)
                        {
                            cnt[0] = 0;
                            cnt[1] = 0;
                            for(int a = x1 - 1; a <= x2 + 1 && cnt[0]*cnt[1]==0;a++)
                            {
                                for(int b = y1 - 1; b <= y2 + 1 && cnt[0]*cnt[1]==0;b++)
                                {
                                    if(wid/31 != ((b + wid)%wid)/31) cnt[((T[a][((b + wid)%wid)/31]/(1<<(30 - ((b + wid)%wid)%31)))&1)]++;
                                    else cnt[((T[a][((b + wid)%wid)/31]/(1<<((wid-1)%31 - ((b + wid)%wid)%31)))&1)]++;
                                }
                            }
                            if(cnt[0]*cnt[1]==0)
                            {
                                if(y2 + work_size >= wid) {
                                    y1 = 0;
                                    y2 = work_size - 1;
                                    x1 = x2 + 1;
                                    if(x2 + work_size >= height1+1) x2 = height1;
                                    else x2 = x1 + work_size -1;
                                } else {
                                    y1 = y2 + 1;
                                    if(y2 + work_size >= wid) y2 = wid-1;
                                    else y2 = y1 + work_size -1;
                                }
                            }
                        }
                        if(x1 <= height1)
                        {
                            work[j] <: x1;
                            work[j] <: y1;
                            work[j] <: x2;
                            work[j] <: y2;

                            for(int a = x1 - 1; a <= x2 + 1;a++){
                                for(int b = y1 - 1; b <= y2 + 1;b++){
                                    if(wid/31 != ((b + wid)%wid)/31) work[j] <: ((T[a][((b + wid)%wid)/31]/(1<<(30 - ((b + wid)%wid)%31)))&1);
                                    else work[j] <: ((T[a][((b + wid)%wid)/31]/(1<<((wid-1)%31 - ((b + wid)%wid)%31)))&1);
                                }
                            }
                            //We set coordinates of the very next area to send
                            if(y2 + work_size >= wid)
                            {
                                y1 = 0;
                                y2 = work_size - 1;
                                x1 = x2 + 1;
                                if(x2 + work_size >= height1+1) x2 = height1;
                                else x2 = x1 + work_size -1;
                            }
                            else
                            {
                                y1 = y2 + 1;
                                if(y2 + work_size >= wid) y2 = wid-1;
                                else y2 = y1 + work_size -1;
                            }
                        } else {
                            //all areas have been assigned, worker j terminates
                            work[j] <: -1;
                            work[j] <: -1;
                            work[j] <: -1;
                            work[j] <: -1;
                            finishedThreads++;
                        }
                    }
                    else if(data == 1){         //check if the worker is ready to send data back
                        int areaX1, areaX2, areaY1, areaY2;

                        //receive data from workers
                        work[j] :> areaX1;
                        work[j] :> areaY1;
                        work[j] :> areaX2;
                        work[j] :> areaY2;

                        //put the data from the workers into the answer array
                        for(int a = areaX1; a<=areaX2;a++)
                        {
                            for(int b = areaY1; b<=areaY2;b++)
                            {
                                int k;
                                work[j] :> k;
                                if(k==1)
                                {
                                    if(wid/31 != b/31) ans[a-1][b/31] += (1<<(30 - b%31));
                                    else{
                                        ans[a-1][b/31] += (1<<((wid-1)%31 - b%31));
                                    }
                                }
                            }
                        }
                    }
                    break;
                }
        }
        for(int i = 0; i < numberOfThreads1; i++){
            work[i] <: 2;
        }

        //copy the answer into the T array for the next computation
        for(int i = 1; i <= height1; i++){
            for(int j = 0; j < wid/32 + 1; j++){
                T[i][j] = ans[i - 1][j];
            }
        }

        //send information to the distributor 2
        for(int j = 0; j < wid/32 + 1; j++){
            toDistributor2 <: ans[0][j];
        }
        for(int j = 0; j < wid/32 + 1; j++){
            toDistributor2 <: ans[height1 - 1][j];
        }
        for(int j = 0; j < wid/32 + 1; j++){
            toDistributor2 :> T[height1 + 1][j];
        }
        for(int j = 0; j < wid/32 + 1; j++){
            toDistributor2 :> T[0][j];
        }

        c_out :> signal;    //get data from dataOutStream

        if( signal == 1 )
        {
           //Send the image to DataOutStream
           fromController <: 1;
           //If we have already transposed image, we have to send data in different order
           if(IMHT>=IMWD || transpose==0)
           {
               for(int i=0; i < height1; i++)
               {
                   for(int j=0; j < (wid - 1)/31 ; j++)
                   {
                       for(int k = 30; k >= 0; k--)
                       {
                           if( ((ans[i][j] / (1<<k)) & 1) == 1) c_out <: (uchar) (255);
                           else c_out <: (uchar) (0);
                           ans[i][j] = ans[i][j] % (1<<k);
                       }
                   }
                   for(int k = (wid - 1)%31; k>=0; k--)
                   {
                       if( ((ans[i][(wid-1)/31] / (1<<k)) & 1) == 1) c_out <: (uchar) (255);
                       else c_out <: (uchar) (0);
                       ans[i][(wid-1)/31] = ans[i][(wid-1)/31] % (1<<k);
                   }
               }
           }
           else
           {
               for(int j=0; j < (wid - 1)/31 ; j++)
               {
                   for(int k=30;k>=0;k--)
                   {
                       for(int i=0;i<height1;i++)
                       {
                           if( ((ans[i][j] / (1<<k)) & 1) == 1) c_out <: (uchar) (255);
                           else c_out <: (uchar) (0);
                           ans[i][j] = ans[i][j] % (1<<k);
                       }
                   }
               }
               for(int k = (wid - 1)%31; k>=0; k--)
               {
                   for(int i=0;i<height1;i++)
                   {
                       if( ((ans[i][(wid - 1)/31] / (1<<k)) & 1) == 1) c_out <: (uchar) (255);
                       else c_out <: (uchar) (0);
                       ans[i][(wid - 1)/31] = ans[i][(wid - 1)/31] % (1<<k);
                   }
               }
           }
       }

       fromController <: 0;
       rounds++;
       firstRound = 1;
    }
}

void distributor2(chanend fromController, chanend work[numberOfThreads2], chanend c_out, chanend toDistributor1){

    uchar val;

    unsigned int T[height2 + 2][wid/31 + 2];
    unsigned int ans[height2+2][wid/31 + 2];
    int finishedThreads = 0;

    int firstRound = 0;
    int ok = 0;
    int signal;

    int rounds = 0;

    while(rounds<noOfRounds){

        for( int i = 0; i<height2+2; i++){
               for( int j = 0; j < wid/31 + 2; j++){
                   ans[i][j] = 0;
            }
        }
        finishedThreads = 0;
        if( firstRound == 0 ){
            for( int i = 0; i<height2+2; i++){
                   for( int j = 0; j < wid/31 + 2; j++){
                       T[i][j] = 0;
                }
            }
            if(IMHT>=IMWD|| transpose==0)
            {
                for( int y = height2 + 1; y <= height2 || ok == 0; y++)
                {
                    int a = 0, b = 0, c = 0;
                    for( int x = 1; x <= IMWD; x++){
                        fromController :> val;                    //read the pixel value
                        b *= 2;
                        if(val != 0) b++;
                        a++;
                        if(a==31)
                        {
                            a = 0;
                            T[y][c] = b;
                            b = 0;
                            c++;
                        }

                    }
                    T[y][c] = b;

                    if( ok == 0 ){
                                ok = 1;
                                y = -1;
                    }
                }
            }
            else
            {
                for(int i=0; i<IMHT;i++)
                {
                    ok = 0;
                    for(int j=height2+1;j<=height2 || ok ==0;j++)
                    {
                        fromController :> val;
                        T[j][i/31]*=2;
                        if(val!=0)T[j][i/31]++;
                        if(ok==0)
                        {
                            ok = 1;
                            j = -1;

                        }
                    }
                }
            }
        }
        int x1=1, x2= work_size, y1=0, y2=work_size-1;
        while(finishedThreads < numberOfThreads2)
        {
            select
            {
                case work [int j] :> int data:
                if(data == -1)
                {
                    int cnt[2];
                    cnt[0] = 0;
                    cnt[1] = 0;
                    while(cnt[0]*cnt[1]==0 && x1 <= height2)
                    {
                        cnt[0] = 0;
                        cnt[1] = 0;
                        for(int a = x1 - 1; a <= x2 + 1 && cnt[0]*cnt[1]==0;a++)
                        {
                            for(int b = y1 - 1; b <= y2 + 1 && cnt[0]*cnt[1]==0;b++)
                            {
                                if(wid/31 != ((b + wid)%wid)/31) cnt[((T[a][((b + wid)%wid)/31]/(1<<(30 - ((b + wid)%wid)%31)))&1)]++;
                                else cnt[((T[a][((b + wid)%wid)/31]/(1<<((wid-1)%31 - ((b + wid)%wid)%31)))&1)]++;
                            }
                        }
                        if(cnt[0]*cnt[1]==0)
                        {
                            if(y2 + work_size >= wid) {
                                y1 = 0;
                                y2 = work_size - 1;
                                x1 = x2 + 1;
                                if(x2 + work_size >= height2+1) x2 = height2;
                                else x2 = x1 + work_size -1;
                            } else {
                                y1 = y2 + 1;
                                if(y2 + work_size >= wid) y2 = wid-1;
                                else y2 = y1 + work_size -1;
                            }
                        }

                    }

                    if(x1 <= height2)
                    {
                        work[j] <: x1;
                        work[j] <: y1;
                        work[j] <: x2;
                        work[j] <: y2;

                        for(int a = x1 - 1; a <= x2 + 1;a++){
                            for(int b = y1 - 1; b <= y2 + 1;b++){
                                if(wid/31 != ((b + wid)%wid)/31) work[j] <: ((T[a][((b + wid)%wid)/31]/(1<<(30 - ((b + wid)%wid)%31)))&1);
                                else
                                {
                                    work[j] <: ((T[a][((b + wid)%wid)/31]/(1<<((wid-1)%31 - ((b + wid)%wid)%31)))&1);

                                }

                            }
                        }
                        if(y2 + work_size >= wid)
                        {
                            y1 = 0;
                            y2 = work_size - 1;
                            x1 = x2 + 1;
                            if(x2 + work_size >= height2+1) x2 = height2;
                            else x2 = x1 + work_size -1;
                        }
                        else
                        {
                            y1 = y2 + 1;
                            if(y2 + work_size >= wid) y2 = wid-1;
                            else y2 = y1 + work_size -1;
                        }
                    } else {
                        work[j] <: -1;
                        work[j] <: -1;
                        work[j] <: -1;
                        work[j] <: -1;
                        finishedThreads++;
                    }
                } else if(data == 1)
                {
                    int areaX1, areaX2, areaY1, areaY2;

                    work[j] :> areaX1;
                    work[j] :> areaY1;
                    work[j] :> areaX2;
                    work[j] :> areaY2;

                    for(int a = areaX1; a<=areaX2;a++)
                    {
                        for(int b = areaY1; b<=areaY2;b++)
                        {
                            int k;
                            work[j] :> k;
                            if(k==1)
                            {
                                if(wid/31 != b/31) ans[a-1][b/31] += (1<<(30 - b%31));
                                else ans[a-1][b/31] += (1<<((wid-1)%31 - b%31));
                            }
                        }
                    }
                }
                break;
            }
        }
        for(int i = 0; i < numberOfThreads2; i++){
            work[i] <: 2;
        }

        for(int i = 1; i <= height2; i++){
            for(int j = 0; j < wid/32 + 1; j++){
                T[i][j] = ans[i - 1][j];
            }
        }
        for(int j = 0; j < wid/32 + 1; j++){
            toDistributor1 :> T[height2 + 1][j];
        }
        for(int j = 0; j < wid/32 + 1; j++){
            toDistributor1 :> T[0][j];
        }
        for(int j = 0; j < wid/32 + 1; j++){
            toDistributor1 <: ans[0][j];
        }
        for(int j = 0; j < wid/32 + 1; j++){
            toDistributor1 <: ans[height2 - 1][j];
        }

       c_out :> signal;

       if( signal == 1 ){
          fromController <: 1;
          if(IMHT>=IMWD || transpose==0)
          {
              for(int i=0; i < height2; i++)
              {
                  for(int j=0; j < (wid - 1)/31 ; j++)
                  {
                      for(int k = 30; k >= 0; k--)
                      {
                          if( ((ans[i][j] / (1<<k)) & 1) == 1) c_out <: (uchar) (255);
                          else c_out <: (uchar) (0);
                          ans[i][j] = ans[i][j] % (1<<k);
                      }
                  }
                  for(int k = (wid - 1)%31; k>=0; k--)
                  {
                      if( ((ans[i][(wid-1)/31] / (1<<k)) & 1) == 1) c_out <: (uchar) (255);
                      else c_out <: (uchar) (0);
                      ans[i][(wid-1)/31] = ans[i][(wid-1)/31] % (1<<k);
                  }
              }
          }
          else
          {
              for(int j=0; j < (wid - 1)/31 ; j++)
              {
                  for(int k=30;k>=0;k--)
                  {
                      for(int i=0;i<height2;i++)
                      {
                          if( ((ans[i][j] / (1<<k)) & 1) == 1) c_out <: (uchar) (255);
                          else c_out <: (uchar) (0);
                          ans[i][j] = ans[i][j] % (1<<k);
                      }
                  }
              }
              for(int k = (wid - 1)%31; k>=0; k--)
              {
                  for(int i=0;i<height2;i++)
                  {
                      if( ((ans[i][(wid - 1)/31] / (1<<k)) & 1) == 1) c_out <: (uchar) (255);
                      else c_out <: (uchar) (0);
                      ans[i][(wid - 1)/31] = ans[i][(wid - 1)/31] % (1<<k);
                  }
              }
          }
          fromController <: 1;
       }
       fromController <: 0;
       rounds++;
       firstRound = 1;
    }
}


/////////////////////////////////////////////////////////////////////////////////////////
//
// Write pixel stream from channel c_in to PGM image file
//
/////////////////////////////////////////////////////////////////////////////////////////
void DataOutStream(chanend c_in1, chanend c_in2, chanend fromButtons, chanend fromDataInStream){
  int res;
  int start;
  int signal;

  int rounds = 0;

  uchar line[ IMWD ];

  while(rounds<noOfRounds){
      //Open PGM file

      if( rounds == 0 ){
          fromDataInStream :> start;
      }

      select{
          case fromButtons :> signal:
              c_in1 <: 1;
              c_in2 <: 1;

              printf( "DataOutStream:Start...\n" );
              res = _openoutpgm( outfname, IMWD, IMHT );
              if( res ) {
                  printf( "DataOutStream:Error opening %s\n.", outfname );
                  return;
              }

              //Compile each line of the image and write the image line-by-line
              for( int y = 0; y < IMHT; y++ ) {
                  for( int x = 0; x < IMWD; x++ ) {
                      //If we transposed the matrix then we have to transpose it again
                      if(IMHT>=IMWD || transpose==0)
                      {
                          if( y < height1 ){
                              c_in1 :> line[ x ];
                          } else {
                              c_in2 :> line[ x ];
                          }
                      }
                      else
                      {
                          if( x < height1 )
                          {
                              c_in1 :> line[ x ];
                          }
                          else
                          {
                              c_in2 :> line[ x ];
                          }
                      }
                  }
                  _writeoutline( line, IMWD );
                  //_writeoutline( line, IMWD );
              }
              //Close the PGM image
              _closeoutpgm();
              printf( "DataOutStream:Done...\n" );
              break;
         default:
              c_in1 <: 0;
              c_in2 <: 0;
          break;
      }

      rounds++;
  }
  return;
}

/////////////////////////////////////////////////////////////////////////////////////////
//
// Initialise and  read accelerometer, send first tilt event to channel
//
/////////////////////////////////////////////////////////////////////////////////////////
void accelerometer(client interface i2c_master_if i2c, chanend toController) {
  i2c_regop_res_t result;
  char status_data = 0;
  int tilted = 0;

  // Configure FXOS8700EQ
  result = i2c.write_reg(FXOS8700EQ_I2C_ADDR, FXOS8700EQ_XYZ_DATA_CFG_REG, 0x01);
  if (result != I2C_REGOP_SUCCESS) {
    printf("I2C write reg failed\n");
  }
  
  // Enable FXOS8700EQ
  result = i2c.write_reg(FXOS8700EQ_I2C_ADDR, FXOS8700EQ_CTRL_REG_1, 0x01);
  if (result != I2C_REGOP_SUCCESS) {
    printf("I2C write reg failed\n");
  }

  //Probe the accelerometer x-axis forever
  while (1) {

    //check until new accelerometer data is available
    do {
      status_data = i2c.read_reg(FXOS8700EQ_I2C_ADDR, FXOS8700EQ_DR_STATUS, result);
    } while (!status_data & 0x08);

    //get new x-axis tilt value
    int x = read_acceleration(i2c, FXOS8700EQ_OUT_X_MSB);

    //send signal to distributor after first tilt
    if (!tilted) {
      if ( x>30 || x<-30 ) {
        toController <: 1;
      } else {
          toController <: 0;
      }
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////
//
// Orchestrate concurrent system and start up all threads
//
/////////////////////////////////////////////////////////////////////////////////////////
int main(void) {

  i2c_master_if i2c[1];

  chan c_inIO, c_outIO1, c_outIO2, c_control, buttonToDataInStream, distributor1ToWorker[numberOfThreads1],
       distributor2ToWorker[numberOfThreads2], controllerToDistributor1, controllerToDistributor2,
       distributor1ToDistributor2, buttonsToDataOut, dataOutToDataIn;

  par{
   on stdcore[0]: i2c_master(i2c, 1, p_scl, p_sda, 10);   //server thread providing accelerometer data
   on stdcore[0]: accelerometer(i2c[0],c_control);        //client thread reading accelerometer data
   on stdcore[1]: DataInStream(c_inIO, buttonToDataInStream, dataOutToDataIn);          //thread to read in a PGM image
   on stdcore[1]: DataOutStream(c_outIO1, c_outIO2, buttonsToDataOut, dataOutToDataIn);       //thread to write out a PGM image
   on stdcore[0]: controller(leds, c_inIO, c_control, controllerToDistributor1, controllerToDistributor2);  //thread to distribute the image into two halves
   on stdcore[0]: distributor1(controllerToDistributor1, distributor1ToWorker, c_outIO1, distributor1ToDistributor2);  //thread to coordinate work on image
   on stdcore[1]: distributor2(controllerToDistributor2, distributor2ToWorker, c_outIO2, distributor1ToDistributor2);  //thread to coordinate work on image
   on stdcore[0]: buttonListener(buttons, buttonToDataInStream, buttonsToDataOut);  //thread to get the buttons input

   par (int i=0;i<numberOfThreads1;i++){
        on stdcore[0]: worker(distributor1ToWorker[i]);     //worker threads  for distributor 1
    }
    par (int i = 0; i < numberOfThreads2; i++){
        on stdcore[1]: worker(distributor2ToWorker[i]);     //worker threads for distributor 2
    }
  }

  return 0;
}
