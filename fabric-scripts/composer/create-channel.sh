
chmod -R 0755 ./crypto-config
# Delete existing artifacts
rm -rf ./crypto-config
rm genesis.block mlchannel.tx
rm -rf ../../channel-artifacts/*

#Generate Crypto artifactes for organizations
cryptogen generate --config=./crypto-config.yaml --output=./crypto-config/



# System channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "mlchannel"
CHANNEL_NAME="mlchannel"

echo $CHANNEL_NAME

# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL  -outputBlock ./genesis.block


# Generate channel configuration block
configtxgen -profile MLChannel -configPath . -outputCreateChannelTx ./mlchannel.tx -channelID $CHANNEL_NAME

echo "#######    Generating anchor peer update for HerdsmanMSP  ##########"
configtxgen -profile MLChannel -configPath . -outputAnchorPeersUpdate ./HerdsmanMSPanchors.tx -channelID $CHANNEL_NAME -asOrg HerdsmanMSP

echo "#######    Generating anchor peer update for SlaughterMSP  ##########"
configtxgen -profile MLChannel -configPath . -outputAnchorPeersUpdate ./SlaughterMSPanchors.tx -channelID $CHANNEL_NAME -asOrg SlaughterMSP

echo "#######    Generating anchor peer update for RetailerMSP  ##########"
configtxgen -profile MLChannel -configPath . -outputAnchorPeersUpdate ./RetailerMSPanchors.tx -channelID $CHANNEL_NAME -asOrg RetailerMSP