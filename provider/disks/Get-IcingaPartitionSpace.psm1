function Get-IcingaPartitionSpace()
{
    [array]$LogicalDisks = Get-IcingaWindowsInformation Win32_LogicalDisk -Filter 'DriveType != 4';
    [hashtable]$DiskData = @{ };

    foreach ($disk in $LogicalDisks) {
        if ($DiskData.ContainsKey($disk.DeviceID)) {
            continue;
        }

        $DiskData.Add(
            $disk.DeviceID,
            @{
                'Size'        = $disk.Size;
                'FreeSpace'   = $disk.FreeSpace;
                'UsedSpace'   = ($disk.Size - $disk.FreeSpace);
                'DriveLetter' = $disk.DeviceID;
                'VolumeName'  = $disk.VolumeName;
            }
        );
    }

    return $DiskData;
}
