let CID = 'QmUSaXFTm1UpmBVJZQpH4YztnmZXqkRNwfQE9TrNgETtFY'
const storeCID = (_CID) => {
    CID = _CID
}

const readCID = () =>{
    return CID
}

export {
    storeCID,
    readCID
}