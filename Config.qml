import QtQuick 2.4

ConfigFormular {
    visible: false
    configCancelButton.onClicked: visible = false
    configOkButton.onClicked: {

        visible = false
    }
    onVisibleChanged: {
        var conf = {}
        if (visible){
            conf = configData.readConfig(configTitle.text)
            urlField.text = conf["url"]
            loginField.text = conf["login"]
            passwordField.text = conf["password"]

        }else{

            conf["group"] =  configTitle.text
            conf["url"] = urlField.text
            conf["login"] = loginField.text
            conf["password"] = passwordField.text

            configData.setDlgData(conf)
        }
    }

}
