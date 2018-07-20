/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  View,
  Text
} from 'react-native';
import { createStackNavigator } from 'react-navigation';

//Custom components and styles
import Menu from './src/components/Menu/Menu';
import DataInput from './src/components/DataInput/DataInput';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' +
    'Cmd+D or shake for dev menu',
  android: 'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

const RootStack = createStackNavigator(
  {
    MenuScreen: Menu,
    DataInputScreen: DataInput
  },
  {
    initialRouteName: 'MenuScreen',
    headerMode: 'none',
    navigationOptions: {
      headerVisible: false,
      key: this.key
    }
  }
);

export default class App extends Component {

  //handleTextChange = (newText) => this.setState({ value: newText });

  render() {
    return (
      <View style={{flex: 1}}>
        <RootStack />
        {/*<Menu />*/}
        {/*<MenuHeader name={"Gregory"}></MenuHeader>
        <FloatingLabelInputIcon
          icon={Icons.envelope}
          label="Email"
          value={this.state.value}
          onChangeText={this.handleTextChange}
        />
        <FloatingLabelInput
          label="Email"
          value={this.state.value}
          onChangeText={this.handleTextChange}
        /> 
        <CompartmentCard compartmentName={"Personal and Employment"} leftColor={"#0000FF"}
        subComps={[{
          key: 0,
          name: "- Patient"
        },{
          key: 1,
          name: "- Next of Kin"
        }]}>
        </CompartmentCard>*/}
      </View>
    );
  }
}
