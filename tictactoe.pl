#!/usr/bin/perl
# Coded by : Wane Smith
#
# Date:  03June2013
#
# Title: Simple two player Tic Tac Toe
#
# All rights retained by the Author unless otherwise
# contracted to the client
#
# Very simple two player curues tic tac toe program
# run in either windows  or linux command prompt
#

use strict;
use warnings;

# keeps track of the game
my @board = qw/ 1 2 3 4 5 6 7 8 9/;
# possible winning combiniations
my @possible_wins = qw/ 012 345 678 036 147 258 048 246 /;
# X always starts the game
my $turn = "X";
# keeps track of the winner
my $win = 0;
# next move in the game
my $move;
# nine moves and no winner cat
my $cat = 1;
# logical move user move -1
my $logic_move;
# player names
my %player_name;

#
# Starts the game by asking the players names
# perhaps we will make a vs. computer game
# next time
#
sub start_game(){

   print "\n\n\n\n       Name for player X:  ";
   $player_name{"X"} = <STDIN>;
   chomp($player_name{"X"});
   clear_screen();

   print "\n\n\n\n       Name for player O: ";
   $player_name{"O"}= <STDIN>;
   chomp($player_name{"O"});

   clear_screen();
}

#
# draws the screen first of the game and after each move
#
sub draw_board(){

   if ($win ==0 ){

      clear_screen();
   }

   print "\n\n\n";
   print "          $board[0]    |     $board[1]     |       $board[2]\n";
   print "     ----------|-----------|----------\n";
   print "          $board[3]    |     $board[4]     |       $board[5]\n";
   print "     ----------|-----------|----------\n";
   print "          $board[6]    |     $board[7]     |       $board[8]\n" ;
   print "\n\n\n";
   if ($win == 0){

      print "
      Player [$player_name{$turn}] [$turn] choose your move [ 1 - 9 or q ]? : ";


       $move = <STDIN>;
       chomp($move);

       if ($move =~ /q/ ){
          print "Goodbye!!!\n\n";
          exit 0;

       }

       move();
   }


}

#
#
# Who went last?
# Change the player
#
sub turn(){

    if( $turn eq "X" ) {

        $turn = "O" ;

    }else {

        $turn = "X";

    }
}

#
# allows the current user to make a move and see if it is a valid move
#
sub move(){

  my $wait;

    if( $move =~ /^[1-9]$/  ) {
         $logic_move = ($move - 1);
         if ($board[$logic_move] eq "X" || $board[$logic_move] eq "O"){

              print "Sorry $board[$logic_move] has that spot.";
              $wait =<STDIN>;
              draw_board();

         }else {

               $board[$logic_move]=$turn ;
               winner();
               turn();
               draw_board();
         }

    }else{
          print "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
          print "!                                         !\n";
          print "             $move is invalid               \n";
          print "!                                         !\n";
          print "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";

          $wait=<STDIN>;

          draw_board();

    }

}

# see if we have a winner yet

sub winner(){

  my $wait;

  foreach my $combos (@possible_wins) {

     my $first = substr($combos,0,1);
     my $second = substr($combos,1,1);
     my $third = substr($combos,2,1);


     if ("$board[$first]$board[$second]$board[$third]" eq "$turn$turn$turn"){

        clear_screen();

        print "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
        print "!                                         !\n";
        print "!             $turn Wins                      !\n";
        print "!                                         !\n";
        print "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
        print " Congratulations $player_name{$turn} !\n\n";

        $win = 1;
        draw_board();


        exit 0;
      }


   }
#
# made 9 moves and no winner so Cat wins
#
  if($cat == 9){
     clear_screen();
     print "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
     print "!                                         !\n";
     print "!             Cat Wins                    !\n";
     print "!                                         !\n";
     print "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n";
     $win =1;
     draw_board();
     exit 0;
  }else{
    $cat+=1;
  }

}

# very basic method to clear the screen
sub clear_screen(){
   my $wait;
   if ($^O eq "MSWin32"){

      system("cls");

   }elsif($^O eq "linux"){

      system("clear");

   } else {
      print "Not built for $^O\n";
      $wait  = <STDIN>;
      exit 1;
   }
}
#
# control routine
#
sub main(){

   start_game();
   draw_board();

}
#
# start the program.
#

main();



