//React native keychain
import * as Keychain from 'react-native-keychain';

// 512 bit encryption
var CryptoJs = require('crypto-js'); //CryptoJs.SHA256("");

export default class RealmAuth {

    wordNum = ''
    key = '';

    generateKey = (username) => {
        var credentials = Keychain.getGenericPassword();
        var tries = 0;
        while(!credentials && tries < 5) {
            tries++;
            console.log("Attempting to set up keychain. Attempt number " + tries);
            Keychain.setGenericPassword('WalletLess', username);
            credentials = Keychain.getGenericPassword();
        }
        if(tries < 5) {
            this.wordNum = CryptoJs.SHA512(credentials.password).words;
            var keyTemp = new Int8Array(64);
            this.wordNum.forEach(function(n, i) {
            var temp = "";
            if(n >= 0) {
                temp = n.toString(2);
            } else {
                temp = (~n).toString(2);
            }

            //All need to be exactly 32 bits long
            if(temp.length > 32) {
                temp = temp.substring(0, 32);
            }
            while(temp.length < 32) {
                temp = '0' + temp;
            }

            //For every 8 bits create next number in the key
            for(var j = i * 4; j < i * 4 + 4; j++) {
                keyTemp[j] = parseInt(temp.substring(0,8), 2);
                temp = temp.substring(8);
            }
            
            });
            console.log(keyTemp);
            this.key = keyTemp;
        } else {
            console.log("All tries to get realm key used. Realm cannot be opened at this time");
        }

        return this;
    }
    
}