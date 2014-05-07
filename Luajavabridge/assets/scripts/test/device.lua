require("framework.init")


device.showActivityIndicator()

device.hideAcitivityIndicator()

device.showAlert('title','content',function()
  print("callBack")
end)


device.getOpenUDID()

device.openURL("http://www.baidu.com");

device.showInputBox("title","alert","1")