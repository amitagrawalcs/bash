#!/bin/bash

courses=(
"Linux_course/Linux_course1" "Linux_course/Linux_course2" "SQLFundamentals1"
)



usage() {
	echo -e 'Usage:
    ./course_mount.sh -h To print this help message
    ./course_mount.sh -m -c [course] For mounting a given course
    ./course_mount.sh -u -c [course] For unmounting a given course
    If course name is ommited all courses will be (un)mounted'
}

mount_course() {
	SELECTED_COURSE=$1;
	IS_FOUND=false;
	for course in "${courses[@]}"
	do
		if [ $course == $SELECTED_COURSE ]
		then
			IS_FOUND=true;
			COURSE_NAME="$(echo $SELECTED_COURSE | grep -oE "[^/]+$")";
			check_mount $COURSE_NAME
			if [ $IS_MOUNTED == true ]
			then 
				echo "$SELECTED_COURSE is already mounted";
			else 
				mkdir -p /home/trainee/$COURSE_NAME ;
				bindfs -p 0555 -u trainee -g ftpaccess "/courses/$SELECTED_COURSE" "/home/trainee/$COURSE_NAME" ;
				echo "$SELECTED_COURSE is mounted";
				#chown -R trainee:ftpaccess /home/trainee/$SELECTED_COURSE ;
				#echo "Not mounted already";
			fi
			break;
		fi
	done
	
	if [ $IS_FOUND == false ]; then echo "Entered wrong course"; fi;
}


# function to mount all courses
mount_all() {
    # Loop through courses array
    # call mount_course
    for COURSE in "${courses[@]}"
    do	
    	mount_course $COURSE;
    done
    
}


# function for unmount course
unmount_course() {
    # Check if mount exists
    # If mount exists unmount and delete directory in target folder
    
    SELECTED_COURSE=$1;
    IS_FOUND=false;
    for COURSE in "${courses[@]}"
    do		
    	if [ $COURSE == $SELECTED_COURSE ]
    	then
    		IS_FOUND=true;
		COURSE_NAME="$(echo $SELECTED_COURSE | grep -oE "[^/]+$")";
		check_mount $COURSE_NAME
		if [ $IS_MOUNTED == true ]
		then 
			sudo umount /home/trainee/$COURSE_NAME;
			rm -rf /home/trainee/$COURSE_NAME;
			echo "$SELECTED_COURSE is unmounted";
		else
			echo "$SELECTED_COURSE is not mounted";
		fi
		break;
	fi
	done
	
	if [ $IS_FOUND == false ]; then echo "Entered wrong course"; fi;
}

# sudo findmnt --target /home/trainee/Linux_course/Linux_course1 | awk '{print $3}'| sed 1d
IS_MOUNTED=false
check_mount() {    
	# Return 0 if mount exists 1 if not exists
	#VAR="$(findmnt --target "/home/trainee/$1")";
	VAR="$(sudo findmnt --target "/home/trainee/$1" | awk '{print $3}'| sed 1d)";
	#if [ $? == 0 ]
	if [ "$VAR" == "fuse" ]
	then
		IS_MOUNTED=true
	else
		IS_MOUNTED=false
	fi
}

# function for unmount all courses
unmount_all() {
    # Loop through courses array
    # call unmount_course
    for COURSE in "${courses[@]}"
    do	
    	unmount_course $COURSE;
    done
}

# "Linux_course/Linux_course1" "Linux_course/Linux_course2" "SQLFundamentals1"

#mount_all;
#unmount_all;
#unmount_course "SQLFundamentals1";
#unmount_course "Linux_course/Linux_course1";
#unmount_course "Linux_course/Linux_course2";

#mount_course "SQLFundamentals1";
#check_mount "Linux_course2";
#echo $IS_MOUNTED

#if [ -z $1 ] ; then echo "Provide some option";
#elif [ $1 == '-h' ] ; then usage ;
#elif [ $1 == '-m' ] ; then if [ -z $2 ] ;then mount_all; else mount_course $3; fi ;
#elif [ $1 == '-u' ] ; then if [ -z $2 ] ; then unmount_all; else unmount_course $3; fi ;
#else echo "Wrong options"; fi ;

#0 for mount
#1 for unmount
#2 for undefined

OPERATION=2
IS_C_GIVEN=false
C_COURSE=''
while [ -n "$1" ]; do
	case "$1" in
	-h) usage; shift; break ;;
	-m) OPERATION=0; shift ;; 
	-u) OPERATION=1; shift ;; 
	-c) if [ -z $2 ]; then echo "Provide course"; shift ; exit 2; else IS_C_GIVEN=true; C_COURSE=$2 ; shift 2; fi ;;
	*) echo "Option $1 not recognized"; shift ; exit 2;;
	esac
done

if [ $OPERATION -ne 2 ]; then
	if [ $IS_C_GIVEN == true ]; then
		if [ $OPERATION == 0 ]; then mount_course $C_COURSE; else unmount_course $C_COURSE;  fi;
	else
		if [ $OPERATION == 0 ]; then mount_all; else unmount_all;  fi;
	fi
else usage;
fi

