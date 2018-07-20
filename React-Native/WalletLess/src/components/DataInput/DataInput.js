import React, { Component } from 'react';
import {
    View,
    StatusBar,
    ScrollView,
    TextInput,
    Text,
    Animated,
    StyleSheet
} from 'react-native';
import DataInputHeader from './DataInputHeader';
import FloatingLabelInput from './../FloatingLabelInput/FloatingLabelInput';

//Realm
const Realm = require('realm');

export default class DataInput extends Component {

    //Pass data files and realm to open
    navigation = '';
    data = '';
    schema = '';
    compartmentName = '';
    encryptKey = '';

    constructor(props) {
        super(props);

        this.state = { realm: null };

        const { navigation } = this.props;
        this.navigation = navigation;
        this.data = navigation.getParam('data', {});
        this.schema = navigation.getParam('schema', null);
        this.encryptKey = navigation.getParam('encryptKey', '');
        this.compartmentName = navigation.getParam('compartmentName', '');
    }

    componentWillMount() {
        Realm.open({
            schema: [this.schema], encryptionKey: this.encryptKey
        }).then(realm => {
            let allInfo = realm.objects(this.schema.name);
            //realm.delete(allInfo); // to delete all in the table
            if(allInfo.length == 0) {
                console.log(this.schema.name + " table was never created.");
            } else {
                this.setState({ realm });
            }
        });
    }
    
    render() {

        const values = this.state.realm ? Array.from(this.state.realm.objects(this.schema.name))[0] : {};

        return (
            <View>
                <DataInputHeader navigation={this.navigation} compartmentName={this.compartmentName} />
                <ScrollView>
                    {this.data.map(info => (
                        <FloatingLabelInput key={info.key} field={info.field} label={info.label} type={info.type} value={values[info.field]} />
                    ))}
                </ScrollView>
            </View>
        );
    }
}