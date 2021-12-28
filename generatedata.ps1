$MaxBytes = 1.9GB    # The maximum amount of random data that will be generated
$FileSize = 50MB     # The size of each randomly generated file that gets created
$TotalBytes = 0      # Initialize the amount of randomly generated data to 0

# Get the current date
$Date = (Get-Date -Format yyyy-MM-dd)

# Create directory based on date, if it doesn't exist
New-Item -Path $Date -ItemType Directory -ErrorAction Ignore

do {
  # Generate a random file path
  $FilePath = '{0}\{1}' -f $Date, (New-Guid).Guid

  [System.Security.Cryptography.RNGCryptoServiceProvider] $rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
  $rndbytes = New-Object byte[] $FileSize
  $rng.GetBytes($rndbytes)
  [System.IO.File]::WriteAllBytes($FilePath, $rndbytes)
  
  $TotalBytes += $FileSize
} while ($TotalBytes -lt $MaxBytes)
