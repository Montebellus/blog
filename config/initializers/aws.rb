require 'aws-sdk-s3'

Aws.config.update({
  region: 'sa-east-1',
  credentials: Aws::Credentials.new('AKIAU4X2HKWWZGLYE5MZ', 'SRvPTAAXVvpJmUlPu7K7f7nuueRiqAnHUzmi6A1Q')
})
