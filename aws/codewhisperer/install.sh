# Install AWS CLI if not already installed
if ! command -v aws &> /dev/null; then
  echo "AWS CLI not found, installing..."
  curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
  sudo installer -pkg AWSCLIV2.pkg -target /
  rm AWSCLIV2.pkg
fi

# Configure AWS CodeWhisperer
mkdir -p ~/.aws
cp "$(pwd)/aws/codewhisperer/config" ~/.aws/config

echo "AWS CodeWhisperer installation and configuration complete!"
