# This script is to fetch disk attached to Dell server using Redfish API.

1. This bash script is interactive which prompt for IDRAC IP and credentials of Idrac
2. This script will get Disk slot number, disk lifetime remaining and Disk size
   
Script output will look like this 

$ sh drac_redfish_api_dell.sh 

Enter iDRAC IP: 192.168.0.111
Enter username: root
Enter password:

Output:

{
  "ID": "Disk.Bay.3:Enclosure.Internal.0-1:RAID.SL.3-1",
  
  "LifeRemainingPercent": 70,
  
  "SerialNumber": "XXxx8889222xxxxxxx",
  
  "Total_Disk_size_bytes": 480103981056
}
