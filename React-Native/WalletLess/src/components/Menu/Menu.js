import React, { Component } from 'react';
import {
    Alert,
    View,
    ScrollView,
    TouchableHighlight,
    StatusBar,
    TextInput,
    Text,
    Animated,
    StyleSheet,
    Dimensions
} from 'react-native';

import CardCompartment from './../Card/CardCompartment';
import MenuHeader from './MenuHeader';

//Data
import comp from './../../data/compartments.json'
import personal from './../../data/personal.json';

//Realm
const Realm = require('realm');

//Schema
import Personal from './../../schema/Personal';

//Service
import RealmAuth from './../../service/RealmAuth';

const username = 'gsoccer'; //TBD to user's username when account creation is implemented

export default class Menu extends Component {    

    state = {
        value: '',
        realm: null
    };
    
    realmAuth = new RealmAuth();
    wordNum = ''
    key = '';
    compartments = 'default';

    constructor() {
        super();

        this.key = this.realmAuth.generateKey(username).key;
        console.log(this.key);

        Realm.open({
            schema: [Personal], encryptionKey: this.key
        }).then(realm => {
            realm.write(() => {
            let allInfo = realm.objects('Personal');
            //realm.delete(allInfo); // to delete all in the table
            if(allInfo.length == 0) {
                const personInfo = realm.create('Personal', {id: 1});
            }
            console.log(Array.from(realm.objects('Personal')));
            });
            this.setState({realm});
        });

        comp.forEach(element => {
            switch(element.compartmentName) {
                case "Personal and Employment":
                    element["data"] = personal;
                    element["schema"] = Personal;
                    break;
                default:
                    break;
            }
        });
    }

    render() {

        console.log(this.key);

        return (
            <View style={styles.container}>
                <MenuHeader style={styles.header} name={'Gregory'}/>
                <ScrollView style={styles.scroll}>
                    {comp.map(info => (
                        <TouchableHighlight key={info.key} onPress={() => this.props.navigation.navigate('DataInputScreen', {
                            data: info["data"],
                            schema: info["schema"],
                            encryptKey: this.key
                            })} 
                            underlayColor="transparent">
                            <CardCompartment compartmentName={info.compartmentName} leftColor={info.leftColor} percent={info.percent} subComps={info.subComps}/>
                        </TouchableHighlight>
                    ))}
                </ScrollView>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        //flexDirection: 'column'
    },
    header: {
        //flex: 1
    },
    scroll: {
        backgroundColor: '#f8f8f8',
    }
});