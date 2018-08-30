//  Created by react-native-create-bridge

import React, { Component } from 'react'
import { requireNativeComponent,DeviceEventEmitter} from 'react-native'

const IosMathBridge = requireNativeComponent('IosMathBridge', IosMathBridgeView);

// const HelloWordEmitter = new NativeEventEmitter(IosMathBridge);


export default class IosMathBridgeView extends Component {


  constructor() {
    super();
    this.state={
      width: 0,
      height: 0
    }

    this.subscriptions = [];
}

  componentDidMount() {

    var sub = DeviceEventEmitter.addListener(
            'SIZE_CHANGED',
            (event) => {
              console.log("SIZE_CHANGED", event);
              this.setState({
                height: event.height,
                width: event.width
              });
            }
        );

        this.subscriptions.push(sub);
}

componentWillUnmount() {
  this.subscriptions.forEach(sub => sub.remove());
  this.subscriptions = [];
}

  render () {
    return <IosMathBridge width={this.state.width} height={this.state.height} {...this.props} />
  }
}
