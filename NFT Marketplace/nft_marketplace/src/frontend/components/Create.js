import { useState } from 'react'
import { ethers } from "ethers"
// import { web3 } from "web3"
import { Row, Form, Button } from 'react-bootstrap'
import { create as ipfsHttpClient } from 'ipfs-http-client'
import { Buffer } from 'buffer';
const projectId = '2EAAiLvCS4zAYAt6vABl2DVmr9K';
const projectSecret = '6788e31be0c59e54a61055f293c6aacd';
const auth =
  'Basic ' + Buffer.from(projectId + ':' + projectSecret).toString('base64');
const client = ipfsHttpClient({
  host: 'ipfs.infura.io',
  port: 5001,
  protocol: 'https',
  headers: {
    authorization: auth,
  },
});

const Create = ({ marketplace, nft }) => {
  const [image, setImage] = useState('')
  const [price, setPrice] = useState(null)
  const [name, setName] = useState('')
  const [description, setDescription] = useState('')
  const uploadToIPFS = async (event) => {
    event.preventDefault()
    const file = event.target.files[0]
    if (typeof file !== 'undefined') {
      console.log("result1")
      try {
        const result = await client.add(file)
        console.log("result2")
        setImage(`https://ipfs.infura.io/ipfs/${result.path}`)
      } catch (error){
        console.log("ipfs image upload error: ", error)
      }
    }
  }
  const createNFT = async () => {
    if (!image || !price || !name || !description) return
    try{
      const result = await client.add(JSON.stringify({ image, price, name, description }))
      console.log(result);
    } catch(error) {
      console.log("ipfs uri upload error: ", error)
    }
  }
  const mintThenList = async (result) => {
    const uri = `https://ipfs.io/ipfs/${result.path}`
    console.log("uri");
    console.log(uri);
    // mint nft 
    await(await nft.mint(uri)).wait()
    console.log("uri");
    // get tokenId of new nft
    const id = await nft.tokenCount()
    console.log("uri");
    // approve marketplace to spend nft
    await(await nft.setApprovalForAll(marketplace.address, true)).wait()
    console.log("uri");
    // add nft to marketplace
    const listingPrice = ethers.utils.parseEther(price.toString())
    console.log(listingPrice);
    console.log("uri");
    console.log(nft.address);
    await(await marketplace.makeItem(nft.address, id, listingPrice)).wait()
    console.log("uri");
  }
  return (
    <div className="container-fluid mt-5">
      <div className="row">
        <main role="main" className="col-lg-12 mx-auto" style={{ maxWidth: '1000px' }}>
          <div className="content mx-auto">
            <Row className="g-4">
              <Form.Control
                type="file"
                required
                name="file"
                onChange={uploadToIPFS}
              />
              <Form.Control onChange={(e) => setName(e.target.value)} size="lg" required type="text" placeholder="Name" />
              <Form.Control onChange={(e) => setDescription(e.target.value)} size="lg" required as="textarea" placeholder="Description" />
              <Form.Control onChange={(e) => setPrice(e.target.value)} size="lg" required type="number" placeholder="Price in ETH" />
              <div className="d-grid px-0">
                <Button onClick={createNFT} variant="primary" size="lg">
                  Create NFT!
                </Button>
              </div>
              <div className="d-grid px-0">
                <Button onClick={mintThenList} variant="primary" size="lg">
                  Mint & List NFT!
                </Button>
              </div>
            </Row>
          </div>
        </main>
      </div>
    </div>
  );
}

export default Create