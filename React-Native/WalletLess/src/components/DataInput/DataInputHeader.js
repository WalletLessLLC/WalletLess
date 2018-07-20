import React, { Component } from 'react';
import {
    View,
    StatusBar,
    TextInput,
    Text,
    TouchableHighlight,
    Animated,
    StyleSheet
} from 'react-native';
import FontAwesome, { Icons } from 'react-native-fontawesome';

const sideFlex = 5;
const bannerFontSize = 22;

export default class DataInputHeader extends Component {

    render() {
        return (
            <View style={styles.banner}>
                <View style={styles.container}>
                    <TouchableHighlight style={styles.touch} onPress={() => this.props.navigation.goBack()} >
                        <FontAwesome style={styles.back}>
                            {Icons.chevronLeft}
                        </FontAwesome>
                    </TouchableHighlight>
                    <Text style={styles.compText}>{this.props.compartmentName}</Text>
                    <View style={styles.end} />
                </View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    banner: {
        backgroundColor: '#c0c0c0',
        height: 85,
        paddingTop: 20,
    },
    container: {
        flex: 1,
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center'
    },
    touch: {
        flex: sideFlex,
    },
    back: {
        color: '#efefef',
        fontSize: bannerFontSize,
        textAlign: 'center'
    },
    compText: {
        flex: 20,
        textAlign: 'center',
        color: '#efefef',
        fontSize: bannerFontSize,
        fontWeight: '300'
        //paddingBottom: 10
    },
    end: {
        flex: sideFlex
    }
})