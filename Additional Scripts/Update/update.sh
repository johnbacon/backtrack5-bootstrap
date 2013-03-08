#!/bin/sh


menu1() {
   clear
cat <<EOF
######                       #######                                ####### 
#     #   ##    ####  #    #    #    #####    ##    ####  #    #    #       
#     #  #  #  #    # #   #     #    #    #  #  #  #    # #   #     #       
######  #    # #      ####      #    #    # #    # #      ####      ######  
#     # ###### #      #  #      #    #####  ###### #      #  #            # 
#     # #    # #    # #   #     #    #   #  #    # #    # #   #     #     # 
######  #    #  ####  #    #    #    #    # #    #  ####  #    #     #####  
                                                                            
               #     #                                          
               #     # #####  #####    ##   ##### ###### #####  
               #     # #    # #    #  #  #    #   #      #    # 
               #     # #    # #    # #    #   #   #####  #    # 
               #     # #####  #    # ######   #   #      #####  
               #     # #      #    # #    #   #   #      #   #  
                #####  #      #####  #    #   #   ###### #    # 

                  Michael Johnson AKA ZeroCold ZeroCold.co.uk



EOF

echo "    Please Select A Option:"
echo
echo "     1. Update Backtrack."
echo "     2. Upgrade Backtrack."
echo "     3. Distribution Update."
echo "     4. Update Metasploit."
echo "     5. Update Social Engineering Toolkit."
echo "     6. Update Fast-Track."
echo "     7. Update All."
echo "     8. Exit."
echo 
echo -n "ZeroCold>>"
}
menu3() {
   
   while true
   do
   menu1 
   read answer
   case $answer in
   1)
      clear
      apt-get update 
  ;;   
   2)
      clear
      apt-get upgrade
  ;;
   3)
      clear
      apt-get dist-upgrade 
  ;;
   4)
      clear
      cd /pentest/exploits/framework3/
      svn update
      msfupdate  
  ;;
   5)
      clear
      cd /pentest/exploits/set
      ./set-update
  ;;

   6)
      clear
      cd /pentest/exploits/fasttrack
      ./fast-track.py  -c 1 1
  ;;
   7)
      clear 
      apt-get update
      apt-get upgrade
      apt-get dist-upgrade
      cd /pentest/exploits/framework3/
      svn update
      msfupdate
      cd /pentest/exploits/set
      ./set-update  
  ;;
   
   8)
    clear 
    exit
  ;;

   *)
     menu3
  ;;
   esac
   done
}

case "$1" in    
    *)
   menu3
  ;;
esac