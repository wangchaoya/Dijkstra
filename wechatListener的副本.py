import requests
import json
import time
sessionStr = 'NGYyZTNmNzYtN2QyMi00OTk4LTllZDQtY2JlNTkyNDlkYzgy'
cookie = f'SESSION={sessionStr}; Path=/ccip/; HttpOnly; SameSite=Lax'
headers = {
    'Host': 'partner.z-bank.com',
    'Content-Type': 'application/json',
    'uniqueId': '1685987355413',
    'Accept': '*/*',
    'Cookie': cookie,
    'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E217 MicroMessenger/6.8.0(0x16080000) NetType/WIFI Language/en Branch/Br_trunk MiniProgramEnv/Mac',
    'Referer': 'https://servicewechat.com/wxfea8bf521fd5046d/146/page-frame.html',
    'Accept-Language': 'zh-cn'
}


def listRequest():

    data = {
    "data": {
                "brandSeries": "SD001",
                "channelNo": "ZX",
                "current": 1,
                "size": 3,
                "transferMarket": "ZLC"
                
            }
    }

    url = 'https://partner.z-bank.com/ccip/zlcProduct/applyList'

    # 创建一个session对象，用于保持keep-alive
    session = requests.Session()

    # 设置session的keep-alive参数为True
    session.keep_alive = True

# 定义一个无限循环，每秒发送一次请求
    while True:
    # 记录当前时间
        start_time = time.time()
    
    # 发送post请求，并获取响应
        response = session.post(url, headers=headers, data=json.dumps(data), verify = True)
        end_time = time.time()
        print(headers)
        print(f"请求耗时: {(end_time - start_time) * 1000:.2f} ms")
    # 打印响应内容
        json_obj = json.loads(response.text)
        apply_array = json_obj["data"]["applyArray"]
        if len(apply_array) > 0:
            print("apply_array的数量大于零")
        else:
            print("apply_array的数量等于零")
    # 计算请求花费的时间
        elapsed_time = time.time() - start_time
    # 如果请求花费的时间小于1秒，就等待剩余的时间
        if elapsed_time < 1:
            time.sleep(1 - elapsed_time)

listRequest()
