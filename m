Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364C6416D8B
	for <lists+linux-crypto@lfdr.de>; Fri, 24 Sep 2021 10:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244640AbhIXIU2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Sep 2021 04:20:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3853 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244629AbhIXIU2 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Sep 2021 04:20:28 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HG4c11nZmz67GQ8;
        Fri, 24 Sep 2021 16:16:01 +0800 (CST)
Received: from lhreml716-chm.china.huawei.com (10.201.108.67) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 10:18:53 +0200
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 09:18:52 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.008; Fri, 24 Sep 2021 09:18:52 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        liulongfang <liulongfang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: RE: [PATCH v3 3/6] hisi_acc_qm: Move PCI device IDs to common header
Thread-Topic: [PATCH v3 3/6] hisi_acc_qm: Move PCI device IDs to common header
Thread-Index: AQHXqhdAyJCzOzD0aEKiWq7RuzmbUquwI0OAgAKxtIA=
Date:   Fri, 24 Sep 2021 08:18:52 +0000
Message-ID: <d21236b3bdfc44e698a66de4b1444a85@huawei.com>
References: <20210915095037.1149-1-shameerali.kolothum.thodi@huawei.com>
 <20210915095037.1149-4-shameerali.kolothum.thodi@huawei.com>
 <fd1624d5-4661-75e7-6c28-bfbfd877f889@nvidia.com>
In-Reply-To: <fd1624d5-4661-75e7-6c28-bfbfd877f889@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.91.242]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF4IEd1cnRvdm95IFtt
YWlsdG86bWd1cnRvdm95QG52aWRpYS5jb21dDQo+IFNlbnQ6IDIyIFNlcHRlbWJlciAyMDIxIDE2
OjExDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVt
LnRob2RpQGh1YXdlaS5jb20+Ow0KPiBrdm1Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1jcnlwdG9Admdlci5rZXJuZWwub3JnDQo+IENjOiBh
bGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgamdnQG52aWRpYS5jb207IExpbnV4YXJtDQo+IDxs
aW51eGFybUBodWF3ZWkuY29tPjsgbGl1bG9uZ2ZhbmcgPGxpdWxvbmdmYW5nQGh1YXdlaS5jb20+
OyBaZW5ndGFvIChCKQ0KPiA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgSm9uYXRoYW4gQ2Ft
ZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgV2FuZ3pob3UgKEIpIDx3YW5n
emhvdTFAaGlzaWxpY29uLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzZdIGhpc2lf
YWNjX3FtOiBNb3ZlIFBDSSBkZXZpY2UgSURzIHRvIGNvbW1vbg0KPiBoZWFkZXINCj4gDQo+IA0K
PiBPbiA5LzE1LzIwMjEgMTI6NTAgUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gTW92
ZSB0aGUgUENJIERldmljZSBJRHMgb2YgSGlTaWxpY29uIEFDQyBkZXZpY2VzIHRvDQo+ID4gYSBj
b21tb24gaGVhZGVyIGFuZCB1c2UgYSB1bmlmb3JtIG5hbWluZyBjb252ZW50aW9uLg0KPiA+DQo+
ID4gVGhpcyB3aWxsIGJlIHVzZWZ1bCB3aGVuIHdlIGludHJvZHVjZSB0aGUgdmZpbyBQQ0kNCj4g
PiBIaVNpbGljb24gQUNDIGxpdmUgbWlncmF0aW9uIGRyaXZlciBpbiBzdWJzZXF1ZW50IHBhdGNo
ZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtDQo+IDxzaGFtZWVy
YWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2Ny
eXB0by9oaXNpbGljb24vaHByZS9ocHJlX21haW4uYyB8IDEyICsrKysrLS0tLS0tLQ0KPiA+ICAg
ZHJpdmVycy9jcnlwdG8vaGlzaWxpY29uL3NlYzIvc2VjX21haW4uYyAgfCAgMiAtLQ0KPiA+ICAg
ZHJpdmVycy9jcnlwdG8vaGlzaWxpY29uL3ppcC96aXBfbWFpbi5jICAgfCAxMSArKysrLS0tLS0t
LQ0KPiA+ICAgaW5jbHVkZS9saW51eC9oaXNpX2FjY19xbS5oICAgICAgICAgICAgICAgfCAgNyAr
KysrKysrDQo+ID4gICA0IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDE2IGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2hpc2lsaWNvbi9o
cHJlL2hwcmVfbWFpbi5jDQo+IGIvZHJpdmVycy9jcnlwdG8vaGlzaWxpY29uL2hwcmUvaHByZV9t
YWluLmMNCj4gPiBpbmRleCA2NWE2NDEzOTZjMDcuLjFkZTY3YjViYWFlMyAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2NyeXB0by9oaXNpbGljb24vaHByZS9ocHJlX21haW4uYw0KPiA+ICsrKyBi
L2RyaXZlcnMvY3J5cHRvL2hpc2lsaWNvbi9ocHJlL2hwcmVfbWFpbi5jDQo+ID4gQEAgLTY4LDgg
KzY4LDYgQEANCj4gPiAgICNkZWZpbmUgSFBSRV9SRUdfUkRfSU5UVlJMX1VTCQkxMA0KPiA+ICAg
I2RlZmluZSBIUFJFX1JFR19SRF9UTU9VVF9VUwkJMTAwMA0KPiA+ICAgI2RlZmluZSBIUFJFX0RC
R0ZTX1ZBTF9NQVhfTEVOCQkyMA0KPiA+IC0jZGVmaW5lIEhQUkVfUENJX0RFVklDRV9JRAkJMHhh
MjU4DQo+ID4gLSNkZWZpbmUgSFBSRV9QQ0lfVkZfREVWSUNFX0lECQkweGEyNTkNCj4gPiAgICNk
ZWZpbmUgSFBSRV9RTV9VU1JfQ0ZHX01BU0sJCUdFTk1BU0soMzEsIDEpDQo+ID4gICAjZGVmaW5l
IEhQUkVfUU1fQVhJX0NGR19NQVNLCQlHRU5NQVNLKDE1LCAwKQ0KPiA+ICAgI2RlZmluZSBIUFJF
X1FNX1ZGR19BWF9NQVNLCQlHRU5NQVNLKDcsIDApDQo+ID4gQEAgLTExMSw4ICsxMDksOCBAQA0K
PiA+ICAgc3RhdGljIGNvbnN0IGNoYXIgaHByZV9uYW1lW10gPSAiaGlzaV9ocHJlIjsNCj4gPiAg
IHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpocHJlX2RlYnVnZnNfcm9vdDsNCj4gPiAgIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBocHJlX2Rldl9pZHNbXSA9IHsNCj4gPiAtCXsgUENJ
X0RFVklDRShQQ0lfVkVORE9SX0lEX0hVQVdFSSwgSFBSRV9QQ0lfREVWSUNFX0lEKSB9LA0KPiA+
IC0JeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSFVBV0VJLCBIUFJFX1BDSV9WRl9ERVZJQ0Vf
SUQpIH0sDQo+ID4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9IVUFXRUksIEhQUkVfUEZf
UENJX0RFVklDRV9JRCkgfSwNCj4gPiArCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0hVQVdF
SSwgSFBSRV9WRl9QQ0lfREVWSUNFX0lEKSB9LA0KPiA+ICAgCXsgMCwgfQ0KPiA+ICAgfTsNCj4g
Pg0KPiA+IEBAIC0yNDIsNyArMjQwLDcgQEAgTU9EVUxFX1BBUk1fREVTQyh1YWNjZV9tb2RlLA0K
PiBVQUNDRV9NT0RFX0RFU0MpOw0KPiA+DQo+ID4gICBzdGF0aWMgaW50IHBmX3FfbnVtX3NldChj
b25zdCBjaGFyICp2YWwsIGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW0gKmtwKQ0KPiA+ICAgew0K
PiA+IC0JcmV0dXJuIHFfbnVtX3NldCh2YWwsIGtwLCBIUFJFX1BDSV9ERVZJQ0VfSUQpOw0KPiA+
ICsJcmV0dXJuIHFfbnVtX3NldCh2YWwsIGtwLCBIUFJFX1BGX1BDSV9ERVZJQ0VfSUQpOw0KPiA+
ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbV9vcHMgaHBy
ZV9wZl9xX251bV9vcHMgPSB7DQo+ID4gQEAgLTkyMSw3ICs5MTksNyBAQCBzdGF0aWMgaW50IGhw
cmVfZGVidWdmc19pbml0KHN0cnVjdCBoaXNpX3FtICpxbSkNCj4gPiAgIAlxbS0+ZGVidWcuc3Fl
X21hc2tfbGVuID0gSFBSRV9TUUVfTUFTS19MRU47DQo+ID4gICAJaGlzaV9xbV9kZWJ1Z19pbml0
KHFtKTsNCj4gPg0KPiA+IC0JaWYgKHFtLT5wZGV2LT5kZXZpY2UgPT0gSFBSRV9QQ0lfREVWSUNF
X0lEKSB7DQo+ID4gKwlpZiAocW0tPnBkZXYtPmRldmljZSA9PSBIUFJFX1BGX1BDSV9ERVZJQ0Vf
SUQpIHsNCj4gPiAgIAkJcmV0ID0gaHByZV9jdHJsX2RlYnVnX2luaXQocW0pOw0KPiA+ICAgCQlp
ZiAocmV0KQ0KPiA+ICAgCQkJZ290byBmYWlsZWRfdG9fY3JlYXRlOw0KPiA+IEBAIC05NTgsNyAr
OTU2LDcgQEAgc3RhdGljIGludCBocHJlX3FtX2luaXQoc3RydWN0IGhpc2lfcW0gKnFtLCBzdHJ1
Y3QNCj4gcGNpX2RldiAqcGRldikNCj4gPiAgIAlxbS0+c3FlX3NpemUgPSBIUFJFX1NRRV9TSVpF
Ow0KPiA+ICAgCXFtLT5kZXZfbmFtZSA9IGhwcmVfbmFtZTsNCj4gPg0KPiA+IC0JcW0tPmZ1bl90
eXBlID0gKHBkZXYtPmRldmljZSA9PSBIUFJFX1BDSV9ERVZJQ0VfSUQpID8NCj4gPiArCXFtLT5m
dW5fdHlwZSA9IChwZGV2LT5kZXZpY2UgPT0gSFBSRV9QRl9QQ0lfREVWSUNFX0lEKSA/DQo+ID4g
ICAJCQlRTV9IV19QRiA6IFFNX0hXX1ZGOw0KPiA+ICAgCWlmIChxbS0+ZnVuX3R5cGUgPT0gUU1f
SFdfUEYpIHsNCj4gPiAgIAkJcW0tPnFwX2Jhc2UgPSBIUFJFX1BGX0RFRl9RX0JBU0U7DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2hpc2lsaWNvbi9zZWMyL3NlY19tYWluLmMNCj4g
Yi9kcml2ZXJzL2NyeXB0by9oaXNpbGljb24vc2VjMi9zZWNfbWFpbi5jDQo+ID4gaW5kZXggOTA1
NTFiZjM4YjUyLi44OTBmZjZhYjE4ZGQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcnlwdG8v
aGlzaWxpY29uL3NlYzIvc2VjX21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3J5cHRvL2hpc2ls
aWNvbi9zZWMyL3NlY19tYWluLmMNCj4gPiBAQCAtMjAsOCArMjAsNiBAQA0KPiA+DQo+ID4gICAj
ZGVmaW5lIFNFQ19WRl9OVU0JCQk2Mw0KPiA+ICAgI2RlZmluZSBTRUNfUVVFVUVfTlVNX1YxCQk0
MDk2DQo+ID4gLSNkZWZpbmUgU0VDX1BGX1BDSV9ERVZJQ0VfSUQJCTB4YTI1NQ0KPiA+IC0jZGVm
aW5lIFNFQ19WRl9QQ0lfREVWSUNFX0lECQkweGEyNTYNCj4gPg0KPiA+ICAgI2RlZmluZSBTRUNf
QkRfRVJSX0NIS19FTjAJCTB4RUZGRkZGRkYNCj4gPiAgICNkZWZpbmUgU0VDX0JEX0VSUl9DSEtf
RU4xCQkweDdmZmZmN2ZkDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2hpc2lsaWNv
bi96aXAvemlwX21haW4uYw0KPiBiL2RyaXZlcnMvY3J5cHRvL2hpc2lsaWNvbi96aXAvemlwX21h
aW4uYw0KPiA+IGluZGV4IDcxNDgyMDFjZTc2ZS4uZjM1YjhmZDFlY2ZlIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvY3J5cHRvL2hpc2lsaWNvbi96aXAvemlwX21haW4uYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvY3J5cHRvL2hpc2lsaWNvbi96aXAvemlwX21haW4uYw0KPiA+IEBAIC0xNSw5ICsxNSw2
IEBADQo+ID4gICAjaW5jbHVkZSA8bGludXgvdWFjY2UuaD4NCj4gPiAgICNpbmNsdWRlICJ6aXAu
aCINCj4gPg0KPiA+IC0jZGVmaW5lIFBDSV9ERVZJQ0VfSURfWklQX1BGCQkweGEyNTANCj4gPiAt
I2RlZmluZSBQQ0lfREVWSUNFX0lEX1pJUF9WRgkJMHhhMjUxDQo+ID4gLQ0KPiA+ICAgI2RlZmlu
ZSBIWklQX1FVRVVFX05VTV9WMQkJNDA5Ng0KPiA+DQo+ID4gICAjZGVmaW5lIEhaSVBfQ0xPQ0tf
R0FURV9DVFJMCQkweDMwMTAwNA0KPiA+IEBAIC0yNDYsNyArMjQzLDcgQEAgTU9EVUxFX1BBUk1f
REVTQyh1YWNjZV9tb2RlLA0KPiBVQUNDRV9NT0RFX0RFU0MpOw0KPiA+DQo+ID4gICBzdGF0aWMg
aW50IHBmX3FfbnVtX3NldChjb25zdCBjaGFyICp2YWwsIGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFy
YW0gKmtwKQ0KPiA+ICAgew0KPiA+IC0JcmV0dXJuIHFfbnVtX3NldCh2YWwsIGtwLCBQQ0lfREVW
SUNFX0lEX1pJUF9QRik7DQo+ID4gKwlyZXR1cm4gcV9udW1fc2V0KHZhbCwga3AsIFpJUF9QRl9Q
Q0lfREVWSUNFX0lEKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBr
ZXJuZWxfcGFyYW1fb3BzIHBmX3FfbnVtX29wcyA9IHsNCj4gPiBAQCAtMjY4LDggKzI2NSw4IEBA
IG1vZHVsZV9wYXJhbV9jYih2ZnNfbnVtLCAmdmZzX251bV9vcHMsDQo+ICZ2ZnNfbnVtLCAwNDQ0
KTsNCj4gPiAgIE1PRFVMRV9QQVJNX0RFU0ModmZzX251bSwgIk51bWJlciBvZiBWRnMgdG8gZW5h
YmxlKDEtNjMpLA0KPiAwKGRlZmF1bHQpIik7DQo+ID4NCj4gPiAgIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgcGNpX2RldmljZV9pZCBoaXNpX3ppcF9kZXZfaWRzW10gPSB7DQo+ID4gLQl7IFBDSV9ERVZJ
Q0UoUENJX1ZFTkRPUl9JRF9IVUFXRUksIFBDSV9ERVZJQ0VfSURfWklQX1BGKSB9LA0KPiA+IC0J
eyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSFVBV0VJLCBQQ0lfREVWSUNFX0lEX1pJUF9WRikg
fSwNCj4gPiArCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0hVQVdFSSwgWklQX1BGX1BDSV9E
RVZJQ0VfSUQpIH0sDQo+ID4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9IVUFXRUksIFpJ
UF9WRl9QQ0lfREVWSUNFX0lEKSB9LA0KPiA+ICAgCXsgMCwgfQ0KPiA+ICAgfTsNCj4gPiAgIE1P
RFVMRV9ERVZJQ0VfVEFCTEUocGNpLCBoaXNpX3ppcF9kZXZfaWRzKTsNCj4gPiBAQCAtODM0LDcg
KzgzMSw3IEBAIHN0YXRpYyBpbnQgaGlzaV96aXBfcW1faW5pdChzdHJ1Y3QgaGlzaV9xbSAqcW0s
IHN0cnVjdA0KPiBwY2lfZGV2ICpwZGV2KQ0KPiA+ICAgCXFtLT5zcWVfc2l6ZSA9IEhaSVBfU1FF
X1NJWkU7DQo+ID4gICAJcW0tPmRldl9uYW1lID0gaGlzaV96aXBfbmFtZTsNCj4gPg0KPiA+IC0J
cW0tPmZ1bl90eXBlID0gKHBkZXYtPmRldmljZSA9PSBQQ0lfREVWSUNFX0lEX1pJUF9QRikgPw0K
PiA+ICsJcW0tPmZ1bl90eXBlID0gKHBkZXYtPmRldmljZSA9PSBaSVBfUEZfUENJX0RFVklDRV9J
RCkgPw0KPiA+ICAgCQkJUU1fSFdfUEYgOiBRTV9IV19WRjsNCj4gPiAgIAlpZiAocW0tPmZ1bl90
eXBlID09IFFNX0hXX1BGKSB7DQo+ID4gICAJCXFtLT5xcF9iYXNlID0gSFpJUF9QRl9ERUZfUV9C
QVNFOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2hpc2lfYWNjX3FtLmggYi9pbmNs
dWRlL2xpbnV4L2hpc2lfYWNjX3FtLmgNCj4gPiBpbmRleCA4YmVmYjU5YzZmYjMuLjJkMjA5YmYx
NTQxOSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2hpc2lfYWNjX3FtLmgNCj4gPiAr
KysgYi9pbmNsdWRlL2xpbnV4L2hpc2lfYWNjX3FtLmgNCj4gPiBAQCAtOSw2ICs5LDEzIEBADQo+
ID4gICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvcGNp
Lmg+DQo+ID4NCj4gPiArI2RlZmluZSBaSVBfUEZfUENJX0RFVklDRV9JRAkJMHhhMjUwDQo+ID4g
KyNkZWZpbmUgWklQX1ZGX1BDSV9ERVZJQ0VfSUQJCTB4YTI1MQ0KPiA+ICsjZGVmaW5lIFNFQ19Q
Rl9QQ0lfREVWSUNFX0lECQkweGEyNTUNCj4gPiArI2RlZmluZSBTRUNfVkZfUENJX0RFVklDRV9J
RAkJMHhhMjU2DQo+ID4gKyNkZWZpbmUgSFBSRV9QRl9QQ0lfREVWSUNFX0lECQkweGEyNTgNCj4g
PiArI2RlZmluZSBIUFJFX1ZGX1BDSV9ERVZJQ0VfSUQJCTB4YTI1OQ0KPiA+ICsNCj4gDQo+IG1h
eWJlIGNhbiBiZSBhZGRlZCB0byBpbmNsdWRlL2xpbnV4L3BjaV9pZHMuaCB1bmRlciB0aGUNCj4g
UENJX1ZFTkRPUl9JRF9IVUFXRUkgZGVmaW5pdGlvbiA/DQoNCk1ha2Ugc2Vuc2UuIFdpbGwgZG8u
DQoNClRoYW5rcywNClNoYW1lZXINCiANCj4gDQo+ID4gICAjZGVmaW5lIFFNX1FOVU1fVjEJCQk0
MDk2DQo+ID4gICAjZGVmaW5lIFFNX1FOVU1fVjIJCQkxMDI0DQo+ID4gICAjZGVmaW5lIFFNX01B
WF9WRlNfTlVNX1YyCQk2Mw0K
