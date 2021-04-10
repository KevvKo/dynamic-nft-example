const DynamicNft = artifacts.require('DynamicNft')
const LinkTokenInterface = artifacts.require('LinkTokenInterface')


const payment = '1000000000000000000'

module.exports = async callback => {
    try {

        const sps = await DynamicNft.deployed()
        const tokenAddress = await sps.LINKToken()

        console.log(`The Token address is: ${tokenAddress}`)    
        const token = await LinkTokenInterface.at(tokenAddress)
        console.log(`Funding contact: ${sps.address}`)
        const tx = await token.transfer(sps.address, payment)
        callback(tx.tx)
    }  catch (error){
        this.callback(error)
    }
}