<#
.SYNOPSIS
    Creates fictional Active Directory users for the CORP enterprise lab.

.DESCRIPTION
    Creates users in departmental Organizational Units and adds each
    account to the appropriate Active Directory security group.

    Passwords are not stored in this script. The administrator is
    prompted to securely enter a temporary password at runtime.

.NOTES
    Project: Active Directory Enterprise Lab
    Domain: corp.connell-lab.local
#>

Import-Module ActiveDirectory

$DefaultPassword = Read-Host `
    "Enter temporary password for new users" `
    -AsSecureString

$users = @(

    # IT Department
    @{
        First    = "Alex"
        Last     = "Morgan"
        Username = "amorgan"
        OU       = "IT"
        Group    = "GG-IT-Users"
    },
    @{
        First    = "Jordan"
        Last     = "Lee"
        Username = "jlee"
        OU       = "IT"
        Group    = "GG-IT-Users"
    },
    @{
        First    = "Taylor"
        Last     = "Brooks"
        Username = "tbrooks"
        OU       = "IT"
        Group    = "GG-IT-Users"
    },

    # Human Resources
    @{
        First    = "Sarah"
        Last     = "Mitchell"
        Username = "smitchell"
        OU       = "Human-Resources"
        Group    = "GG-HR-Users"
    },
    @{
        First    = "David"
        Last     = "Carter"
        Username = "dcarter"
        OU       = "Human-Resources"
        Group    = "GG-HR-Users"
    },
    @{
        First    = "Emily"
        Last     = "Roberts"
        Username = "eroberts"
        OU       = "Human-Resources"
        Group    = "GG-HR-Users"
    },

    # Finance
    @{
        First    = "Michael"
        Last     = "Turner"
        Username = "mturner"
        OU       = "Finance"
        Group    = "GG-Finance-Users"
    },
    @{
        First    = "Jessica"
        Last     = "Adams"
        Username = "jadams"
        OU       = "Finance"
        Group    = "GG-Finance-Users"
    },
    @{
        First    = "Robert"
        Last     = "Wilson"
        Username = "rwilson"
        OU       = "Finance"
        Group    = "GG-Finance-Users"
    },

    # Operations
    @{
        First    = "Amanda"
        Last     = "Lewis"
        Username = "alewis"
        OU       = "Operations"
        Group    = "GG-Operations-Users"
    },
    @{
        First    = "Christopher"
        Last     = "Hall"
        Username = "chall"
        OU       = "Operations"
        Group    = "GG-Operations-Users"
    },
    @{
        First    = "Nicole"
        Last     = "Walker"
        Username = "nwalker"
        OU       = "Operations"
        Group    = "GG-Operations-Users"
    }
)

foreach ($user in $users) {

    $OUPath = "OU=$($user.OU),OU=CORP-Users,DC=corp,DC=connell-lab,DC=local"

    New-ADUser `
        -Name "$($user.First) $($user.Last)" `
        -GivenName $user.First `
        -Surname $user.Last `
        -SamAccountName $user.Username `
        -UserPrincipalName "$($user.Username)@corp.connell-lab.local" `
        -Path $OUPath `
        -AccountPassword $DefaultPassword `
        -Enabled $true `
        -ChangePasswordAtLogon $true

    Add-ADGroupMember `
        -Identity $user.Group `
        -Members $user.Username

    Write-Host `
        "Created $($user.Username) and added to $($user.Group)"
}
