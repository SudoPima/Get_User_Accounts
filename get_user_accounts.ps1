Import-Module ActiveDirectory

# QUERY:: $accounts = Get-AdUser -Filter * | Where-Object {$_.Department -eq "Information Technology"} 

$file = Import-Csv -Path "C:\Users\%\Documents\%\%.csv"


foreach ($user in $file) {

    #$user_account = Get-AdUser -Filter * | Where-Object {$_.GivenName -eq $user.GivenName -and $_.Surname -eq $user.Surname} 
    $base_name = $user.SamAccountName

    
    $user = Get-ADUser -Filter "Name -Like '$base_name'"
    $name = $user.GivenName + ' ' + $user.Surname 

    $pcc_standard = $base_name
    $pcc_wadmin = "wadmin_$($base_name)"
    $pcc_da = "adm_$($base_name)"

    $edu_standard = $base_name
    $edu_wadmin = "wadmin_$($base_name)"
    $edu_dash = "edu-$($base_name)"
    $edu_da = "adm_$($base_name)"

    if ( Get-AdUser -Filter "Name -Like '$($pcc_wadmin)'" | Where-Object {$_.Enabled -eq $True} ) {
        $pcc_wadmin = $pcc_wadmin
    }
    else {
        $pcc_wadmin = 'N/A'
    }

    if ( Get-AdUser -Filter "Name -Like '$($pcc_da)'" | Where-Object {$_.Enabled -eq $True} ) {
        $pcc_da = $pcc_da
    }
    else {
        $pcc_da = 'N/A'
    }

    if ( Get-AdUser -Server 'edu-domain.pima.edu' -Filter "Name -Like '$($edu_wadmin)'" | Where-Object {$_.Enabled -eq $True} ) {
        $edu_wadmin = $edu_wadmin
    }
    else {
        $edu_wadmin = 'N/A'
    }

    if ( Get-AdUser -Server 'edu-domain.pima.edu' -Filter "Name -Like '$($edu_dash)'" | Where-Object {$_.Enabled -eq $True} ) {
        $edu_dash = $edu_dash
    }
    else {
        $edu_dash = 'N/A'
    }

    if ( Get-AdUser -Server 'edu-domain.pima.edu' -Filter "Name -Like '$($edu_da)'" | Where-Object {$_.Enabled -eq $True} ) {
        $edu_da = $edu_da
    }
    else {
        $edu_da = 'N/A'
    }

        
    [PSCustomObject] @{
    Name = $name
    PCC_standard = $pcc_standard
    PCC_Wadmin = $pcc_wadmin
    PCC_DA = $pcc_da

    EDU_standard = $edu_standard
    EDU_Wadmin = $edu_wadmin
    EDU_DASH = $edu_dash
    EDU_DA = $edu_da

    # UPDATE FILEPATH BEFORE RUNNING
    } | Export-Csv "C:\Users\%\Documents\%\%.csv" -notype -Append -Force

}


