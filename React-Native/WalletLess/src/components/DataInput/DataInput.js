import React, { Component } from 'react';
import {
    View,
    StatusBar,
    TextInput,
    Text,
    Animated,
    StyleSheet
} from 'react-native';
import FloatingLabelInput from './../FloatingLabelInput/FloatingLabelInput';

//Realm
const Realm = require('realm');

export default class DataInput extends Component {

    //Pass data files and realm to open
    data = '';
    schema = '';
    encryptKey = '';

    constructor(props) {
        super(props);

        this.state = { realm: null };

        const { navigation } = this.props;
        const data = navigation.getParam('data', {});
        const schema = navigation.getParam('schema', null);
        const encryptKey = navigation.getParam('encryptKey', '');

        this.data = data;
        this.schema = schema;
        this.encryptKey = encryptKey;
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
                {console.log(values)}
                {this.data.map(info => (
                    <FloatingLabelInput key={info.key} field={info.field} label={info.label} type={info.type} value={values[info.field]} />
                ))}
            </View>
        );
    }
}