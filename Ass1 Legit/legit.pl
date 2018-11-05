#!/usr/bin/perl
use File::Copy;
use Cwd;
## init ###
if ($ARGV[0] eq "init"){
  my $file = ".legit";
  if(-d $file){
  print "legit.pl: error: .legit already exists \n" ;
}
  else{
    mkdir ".legit";
    print "Initialized empty legit repository in .legit \n";
  }
}


## add ###
if($ARGV[0] eq "add"){
  my $floder = ".legit/.index";
  my $init_floder=".legit";
  if(!-d $init_floder){
    die "legit.pl: error: no .legit directory containing legit repository exists\n";
  }

  elsif(!-d $floder){
    mkdir $floder;
  }
    shift @ARGV;
    my @all_file = glob("*");
    if(@all_file){
      foreach my $file(@all_file){
        if($file!~ /legit.pl/){
          push @all_file_without_legit,$file;
        }
      }
    }
    foreach my $file (@ARGV){
      if(grep /$file/,@all_file_without_legit){
        copy("$file","$floder");
      }
      else{
      print"legit.pl: error: can not open 'non_existent_file'\n";
    }
    }
  }


## commit ##
sub maxNumber {
  my $max_number=shift @_;
  foreach(@_){
    if($_>$max_number){
      $max_number=$_;
    }
  }
  return $max_number;
}

if($ARGV[0] eq "commit"){
  @flag=();
  shift @ARGV;
  if(@ARGV==2){
    my $floder = ".legit/.index";
    $if_m = shift @ARGV;
    $commit_line = $ARGV[0];
    $commit_floder=".legit/commit";
    if(!-d $floder){
      print"legit.pl: error: fail to commit, have to add first\n";
    }
    else{
    if(!-d $commit_floder){
      mkdir ".legit/commit";
      mkdir "$commit_floder/commit.0";
      opendir (my $F,$floder);
      foreach my $file(readdir $F){
        copy("$floder/$file",".legit/commit/commit.0");
      }
      ### pritn commit into a txt ###
    open FILE,'>>',".legit/commit/commit.txt";
    print FILE "$commit_line\n";
    close FILE;
### determine commit number ###
    open READ,"<",".legit/commit/commit.txt";
    while(@line=<READ>){
      $commit_number = $#line;
    }
    close READ;

    print "Committed as commit $commit_number\n";
      closedir $F;

    }
    else{
      opendir (my $F,$commit_floder);
        foreach $sub_commit_floder(readdir $F){
          if($sub_commit_floder=~ /commit\.([0-9]+)$/){
          push @number,$1;
        }
      }
        my $Max = maxNumber(@number);

        $current_max_floder="commit.$Max";
        opendir (my $C,".legit/commit/$current_max_floder");
        #my @commited_file =<readdir $C>;
        #print"@commited_file\n";
        #closedir $C;
        opendir (my $I,".legit/.index");
        #my @added_file=<readdir $I>;
        #closedir $I;
        foreach my $file_in_index(readdir $I){
          if($file_in_index !~ /^\.\.?$/){
          foreach my $file_in_commited(readdir $C){

            if($file_in_index eq $file_in_commited){

            open my $FI,"<",".legit/.index/$file_in_index";
            @file1=<$FI>;

            open my $fi,"<",".legit/commit/$current_max_floder/$file_in_commited";
            @file2=<$fi>;
            if(@file1 eq @file2){

            }
            else{
              push @flag,"1";
            }
            }


          }
        }
        }
        if($flag[0]==1){
        #  print"nothing to commit\n";
        print"nothing to commit\n";
        }
        else{
        my $latest=$Max+1;
        my $latest_commit_floder=".legit/commit/commit.$latest";
        mkdir $latest_commit_floder;
        opendir (my $S,".legit/.index");
        foreach my $file(readdir $S){
          copy($file,"$latest_commit_floder");
        }
        ### pritn commit into a txt ###
      open FILE,'>>',".legit/commit/commit.txt";
      print FILE "$commit_line\n";
      close FILE;
### determine commit number ###
      open READ,"<",".legit/commit/commit.txt";
      while(@line=<READ>){
        $commit_number = $#line;
      }
      close READ;

      print "Committed as commit $commit_number\n";
      closedir DIR;
      closedir $S

}

  }
}



}

if(@ARGV==3){
  @flag_a=();
  if($ARGV[0] eq "-a"){
    shift @ARGV;
    if($ARGV[0] eq "-m"){
      shift @ARGV;
      my @all_file = glob("*");
      if(@all_file){
        foreach my $file(@all_file){
          if($file!~ /legit.pl/){
            push @all_file_without_legit,$file;
          }
        }
      }
      $index_pathname=".legit/.index";
      opendir (DIR,$index_pathname) or die "can't open this directory";

      foreach my $file(readdir DIR){
        if($file !~ /^\.\.?$/){
          push @dir,$file;
        }
      }
      foreach $file(@all_file_without_legit){

        if(grep /$file/,@dir){
          my $floder = ".legit/.index";
          copy("$file","$floder");
        }
        else{
          $false=1;
          print"$file didn't added to commit because untracked files \n";
        }
      }
          my $floder = ".legit/.index";
          $commit_line = $ARGV[0];
          $commit_floder=".legit/commit";
          if(!-d $commit_floder){
            mkdir ".legit/commit";
            mkdir "$commit_floder/commit.0";
            opendir (my $F,$floder);
            foreach my $file(readdir $F){
              copy("$floder/$file",".legit/commit/commit.0");
            }
            ### pritn commit into a txt ###
          open FILE,'>>',".legit/commit/commit.txt";
          print FILE "$commit_line\n";
          close FILE;
      ### determine commit number ###
          open READ,"<",".legit/commit/commit.txt";
          while(@line=<READ>){
            $commit_number = $#line;
          }
          close READ;

          print "Committed as commit $commit_number\n";
            closedir $F;

          }
          else{
            opendir (my $F,$commit_floder);
              foreach $sub_commit_floder(readdir $F){
                if($sub_commit_floder=~ /commit\.([0-9]+)$/){
                push @number,$1;
              }
            }
              my $Max = maxNumber(@number);

              $current_max_floder="commit.$Max";
              opendir (my $C,".legit/commit/$current_max_floder");
              #my @commited_file =<readdir $C>;
              #print"@commited_file\n";
              #closedir $C;
              opendir (my $I,".legit/.index");
              #my @added_file=<readdir $I>;
              #closedir $I;
              foreach my $file_in_index(readdir $I){
                if($file_in_index !~ /^\.\.?$/){
                foreach my $file_in_commited(readdir $C){

                  if($file_in_index eq $file_in_commited){

                  open my $FI,"<",".legit/.index/$file_in_index";
                  @file1=<$FI>;

                  open my $fi,"<",".legit/commit/$current_max_floder/$file_in_commited";
                  @file2=<$fi>;

                  if(@file1 eq @file2){

                  }
                  else{
                    push @flag_a,"1";
                  }

                  }


                }
              }
              }
              if($flag_a[0]==1){
                print"nothing to commit\n";
              }
              else{
              my $latest=$Max+1;
              my $latest_commit_floder=".legit/commit/commit.$latest";
              mkdir $latest_commit_floder;
              opendir (my $S,".legit/.index");
              foreach my $file(readdir $S){
                copy($file,"$latest_commit_floder");
              }
              ### pritn commit into a txt ###
            open FILE,'>>',".legit/commit/commit.txt";
            print FILE "$commit_line\n";
            close FILE;
      ### determine commit number ###
            open READ,"<",".legit/commit/commit.txt";
            while(@line=<READ>){
              $commit_number = $#line;
            }
            close READ;

            print "Committed as commit $commit_number\n";
            closedir DIR;
            closedir $S

      }

        }




}
}
}



}


# log
if ($ARGV[0] eq "log"){
  open my $F,"<",".legit/commit/commit.txt";
  @line=<$F>;
  for ($number_line=@line;$number_line>0;$number_line--){
    $index = $number_line-1;
    print"$index $line[$index]";
  }
  close $F;
}


## show ##
if ($ARGV[0] eq "show"){
  shift @ARGV;
  if($ARGV[0] =~ /^([0-9]+)\:(.*)/){
    my $index = $1;
    my $file= $2;
    $floder = ".legit/commit/commit.$index";
    opendir (my $H,$floder) or die"legit.pl: error: unknown commit '$index'\n";
    if(!-f $file){
      print"legit.pl: error: '$file' not found in commit $index\n";
    }
    else{
    foreach my $commit_file(readdir $H){
      if($commit_file eq $file){
        open my $F,"<","$floder/$commit_file";
        foreach $line(<$F>){
        push @contant,$line;
      }



        foreach $line(@contant){
          print"$line";
        }

      }
    }
  }
  }
  elsif($ARGV[0] =~ /^\:(.*)/){
  $floder = ".legit/.index";
  $shown_file = $1;
  opendir (my $DIR, $floder);
  if(!-f $shown_file){
    print"legit.pl: error: '$shown_file' not found in index\n";
  }
  else{
  foreach my $index_file(readdir $$DIR){
    if($index_file eq $shown_file){
      open my $F,"<","$floder/$shown_file";
      foreach $line(<$F>){
        print"$line";
  }
}
}
}
}
}
