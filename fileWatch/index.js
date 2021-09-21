const dirTree = require("directory-tree");
const { getFileProperties } = require('get-file-properties')
const resolveAbsPath = require('path').resolve
const AWS = require('aws-sdk')
// a client can be shared by different commands.
const fs = require('fs')
const fse = require('fs-extra')
const pathModule = require('path')

var client = new AWS.S3({
    region: "ap-south-1",
    accessKeyId: "AKIAT7N5CF2WLISO76HD",
    secretAccessKey: "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"
})

const destPath = "../lib/shared";


async function printMeta(filepath) {
    const absPath = resolveAbsPath(filepath);
    console.log(fs.statSync(absPath)?.mtime)
    const keyPath = absPath.replace(resolveAbsPath(destPath), "")
        .replace('\\', "")
        .replace(/^\\\\\?\\/, "")
        .replace(/\\/g, '\/')
        .replace(/\/\/+/g, '\/')
    console.log(keyPath)
    client.upload({
        Bucket: "orca-lib",
        Key: keyPath,
        Body: fs.readFileSync(absPath, { encoding: "utf8" }),
    }, {}, (error, data) => {
        console.log(error);
        console.log('done uploading to s3...!');
        console.log(data);
    });

}

async function recursivePrintFile(tree) {
    if (tree['children']) {
        const directoryList = tree['children'].filter(child => !child.name.startsWith('.'));
        for (let ind = 0; ind < directoryList.length; ind++) {
            const element = directoryList[ind];
            await recursivePrintFile(element)
        }
    }
    else {
        await printMeta(tree['path'])
    }
}


const manageSync = async () => {
    const tree = dirTree(destPath);
    await recursivePrintFile(tree)
}

async function* listAllKeys(opts = { Bucket: "orca-lib" }) {
    do {
        const data = await client.listObjectsV2(opts).promise();
        opts.ContinuationToken = data.NextContinuationToken;
        yield data;
    } while (opts.ContinuationToken);
}


async function handleS3Fetch() {
    for await (const data of listAllKeys()) {
        console.log(data.Contents);
        for (let ind = 0; ind < data.Contents.length; ind++) {
            const s3FileMeta = data.Contents[ind];
            const s3ResObj = await client.getObject({ Bucket: "orca-lib", Key: s3FileMeta['Key'] }).promise();
            fse.outputFileSync(pathModule.join(__dirname, s3FileMeta['Key']), s3ResObj.Body.toString('utf-8'), { encoding: "utf8" })
        }
    }
}

handleS3Fetch();