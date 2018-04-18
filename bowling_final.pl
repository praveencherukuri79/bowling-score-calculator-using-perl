#!/usr/bin/perl

my ($i,@value,@x,@y,@z,@val,$result,@roll1,@roll2,@roll3);
$i=1;

print "please enter roll values below\n\n";

for(my $k=1;$k<11;$k++){
	
	if($k<10){
		LOOP1 :do{
			print "enter frame $i roll 1 value : ";
			$roll1[$k]= <>;
			chomp($roll1[$k]);
			if($roll1[$k] eq ('x') || $roll1[$k] eq ('X')){
				$roll1[$k] =10;
			}

			if( 0 <= $roll1[$k] && $roll1[$k]<=10){

				LOOP2 :do{
					if($roll1[$k]<10){
						print "enter frame $i roll 2 value : ";
						$roll2[$k]=<STDIN>;
						chomp($roll2[$k]);
						if($roll2[$k] eq '/'){
				$roll2[$k] =(10 - $roll1[$k] );
			}
						
						if( ($roll1[$k] + $roll2[$k])<=0 || ($roll1[$k] + $roll2[$k])>10 || $roll2[$k]<0 ){
							print "wrong input for frame $i roll 2 please enter again \n";
							goto LOOP2;
						}
					}
				}
			}
			else{

				print "wrong input for frame $i roll 1 please enter again \n";
				goto LOOP1;
			}
		}
	}

	else{

		LOOP3 :do{
			print "enter frame $i roll 1 value : ";
			$roll1[$k]= <>;
			chomp($roll1[$k]);
			if($roll1[$k] eq ('x') || $roll1[$k] eq ('X')){
				$roll1[$k] =10;
			}
			if(0 <= $roll1[$k] && $roll1[$k]<=10){

				LOOP4 :do{
					print "enter frame $i roll 2 value : ";
					$roll2[$k]=<STDIN>;
					chomp($roll2[$k]);
					if($roll1[$k] eq ('x') || $roll1[$k] eq ('X')){
				$roll1[$k] =10;
			}

					if($roll1[$k]<10){
						my $temp = $roll1[$k] + $roll2[$k];
						if( $temp<=0 || $temp>10 || $roll2[$k]<0){
							print "wrong input for frame $i roll 2 please enter again \n";
							goto LOOP4;
						}
					}

					if($roll1[$k]==10 || ($roll1[$k]+$roll2[$k])==10){

						LOOP5 :do{
							print "enter frame $i roll 3 value : ";
							$roll3[$k]=<STDIN>;
							chomp($roll3[$k]);
							if( $roll1[$k] <=0 && $roll1[$k]>=10){
								print "wrong input for frame $i roll 1 please enter again \n";
								goto LOOP5;
							} 
						} 
					} 
				} 
			}
			else{
				print "wrong input for frame $i roll 1 please enter again \n";
				goto LOOP3;
			}
		}
	}
	
	roll($roll1[$k],$roll2[$k],$roll3[$k]);

	sub roll{
		$x[$i]=$_[0];
		$y[$i]=$_[1];
		$z[$i]=$_[2];

		$value[$i]=$x[$i]+$y[$i]+$z[$i];
		
		if($i>1){
			if($x[$i-1]==10){

				$value[$i-1]+=($x[$i]+$y[$i]);
			}

			if(($x[$i-2]==10)){
				if($x[$i-1]==10){
					$value[$i-2]+=$x[$i];
				}
			}
			if($x[$i-1] != 10){
				if(($x[$i-1]+$y[$i-1])==10){
					$value[$i-1]+=$x[$i];
				}
			}
		}
	}

	$i+=1;

	$result=0;
	for(my $j=1;$j<$i;$j++){

		$result=$result + $value[$j];
	}

	print "\n";
	print "                           BOWLING SCORE CARD                        \n\n";
	format bowling = 
=================================================================================
@<<<<<<<< @<<<<< @<<<<< @<<<<< @<<<<< @<<<<< @<<<<< @<<<<< @<<<<< @<<<<< @<<<<<<
'FRAMES->',FRAME1,FRAME2,FRAME3,FRAME4,FRAME5,FRAME6,FRAME7,FRAME8,FRAME9,FRAME10
@<<<<<<<< @<@<<< @<@<<< @<@<<< @<@<<< @<@<<< @<@<<< @<@<<< @<@<<< @<@<<< @<<@<<@<<
'ROLLS ->', $roll1[1], $roll2[1], $roll1[2], $roll2[2], $roll1[3], $roll2[3], $roll1[4], $roll2[4], $roll1[5], $roll2[5], $roll1[6], $roll2[6], $roll1[7], $roll2[7], $roll1[8], $roll2[8], $roll1[9], $roll2[9], $roll1[10], $roll2[10], $roll3[10]
@<<<<<<<< @<<<<< @<<<<< @<<<<< @<<<<< @<<<<< @<<<<< @<<<<< @<<<<< @<<<<< @<<<<<
'TOTALS->',$value[1], $value[2],$value[3],$value[4],$value[5],$value[6],$value[7],$value[8],$value[9],$value[10]
=================================================================================

.

	$~ ='bowling';
	write;
	print "total score is ---- $result\n\n";
}