require('dotenv').config();
const DynamicNFTContract = artifacts.require('DynamicNft')
const {KOVAN_VRF_COORDINATOR, KOVAN_LINK_TOKEN, KOVAN_KEYHASH} = process.env

module.exports = async (deployer, network, [defaultAccount]) => {
    if(network.startsWith('kovan')){
        await deployer.deploy(DynamicNFTContract, KOVAN_VRF_COORDINATOR, KOVAN_LINK_TOKEN, KOVAN_KEYHASH)
        let dnft = await DynamicNFTContract.deployed();
        console.log('Deployment of DynamicNFT-Contract was successful!')
    }
}