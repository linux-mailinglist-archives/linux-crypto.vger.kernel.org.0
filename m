Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B67738D70F
	for <lists+linux-crypto@lfdr.de>; Sat, 22 May 2021 20:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhEVS5o (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 22 May 2021 14:57:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:27608 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhEVS5o (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 22 May 2021 14:57:44 -0400
IronPort-SDR: fG0u/uOoDj1AawMcT+1ejR9MaHv+u9z27HZ8VO/k9JhaWRqahFnIx1nfWMjFOVAk4B9XPjan4B
 gIc5Gj06ubug==
X-IronPort-AV: E=McAfee;i="6200,9189,9992"; a="265595465"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="gz'50?scan'50,208,50";a="265595465"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2021 11:56:18 -0700
IronPort-SDR: 0o8tYZ1sbTJpWlXTrekO406ylPJTUyne9Vls4ToEZJOEgw6gCEx6IZjiaJ//k9Pycd5hACvAbV
 DvHIoWtakC1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="gz'50?scan'50,208,50";a="629077105"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 22 May 2021 11:56:14 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lkWnG-0000Ne-BD; Sat, 22 May 2021 18:56:14 +0000
Date:   Sun, 23 May 2021 02:55:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Ben Boeckel <me@benboeckel.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Malte Gell <malte.gell@gmx.de>,
        Varad Gautam <varad.gautam@suse.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7,2/4] PKCS#7: Check codeSigning EKU for kernel module
 and kexec pe verification
Message-ID: <202105230248.tf7PLa0j-lkp@intel.com>
References: <20210521094220.1238-3-jlee@suse.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20210521094220.1238-3-jlee@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chun-Yi",

I love your patch! Perhaps something to improve:

[auto build test WARNING on cryptodev/master]
[also build test WARNING on linus/master v5.13-rc2 next-20210521]
[cannot apply to crypto/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Lee-Chun-Yi/Check-codeSigning-extended-key-usage-extension/20210522-220349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: openrisc-randconfig-r015-20210522 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/928555596c9cd62caabf8777ed8152ddac2609ef
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Lee-Chun-Yi/Check-codeSigning-extended-key-usage-extension/20210522-220349
        git checkout 928555596c9cd62caabf8777ed8152ddac2609ef
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from certs/system_keyring.c:17:
   include/keys/system_keyring.h:72:1: error: expected identifier or '(' before '{' token
      72 | {
         | ^
>> include/keys/system_keyring.h:70:19: warning: 'is_key_on_revocation_list' used but never defined
      70 | static inline int is_key_on_revocation_list(struct pkcs7_message *pkcs7,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/is_key_on_revocation_list +70 include/keys/system_keyring.h

    60	
    61	#ifdef CONFIG_SYSTEM_REVOCATION_LIST
    62	extern int add_key_to_revocation_list(const char *data, size_t size);
    63	extern int is_key_on_revocation_list(struct pkcs7_message *pkcs7,
    64					     enum key_being_used_for usage);
    65	#else
    66	static inline int add_key_to_revocation_list(const char *data, size_t size)
    67	{
    68		return 0;
    69	}
  > 70	static inline int is_key_on_revocation_list(struct pkcs7_message *pkcs7,
    71						    enum key_being_used_for usage);
    72	{
    73		return -ENOKEY;
    74	}
    75	#endif
    76	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--cNdxnHkX5QqsyA0e
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICOZLqWAAAy5jb25maWcAnDzJcts4sPf5ClbmMnPIjBZrq1c+QCAoIeIWApToXFiKrSSq
sS2XJM9L/v41AC4ACNpT7zATu7vRaDQavQH077/97qHX6+lpfz3e7x8ff3nfD8+H8/56ePC+
HR8P/+P5iRcn3CM+5X8BcXh8fv359+nl8Hw+Xu69yV/D8V+Dj+f7obc5nJ8Pjx4+PX87fn8F
FsfT82+//4aTOKCrEuNySzJGk7jkpOC3H07n4T8fHwW3j9/v770/Vhj/6S3+Am4ftDGUlYC4
/VWDVi2f28VgPBg0tCGKVw2qASMmWcR5ywJANdlofNNyCH1Bugz8lhRAblINMdCkXQNvxKJy
lfCk5aIhaBzSmLQomn0ud0m2AQio6ndvJZX/6F0O19eXVnnLLNmQuATdsSjVRseUlyTeligD
mWhE+e14BFzqeZMopSEBfTPuHS/e8+kqGDeLSDAK61V8+OAClyjXF7LMKSycoZBr9D4JUB5y
KYwDvE4Yj1FEbj/88Xx6Pvz5oZWP3bEtTbEuWoPbIY7X5eec5MQhOs4SxsqIREl2VyLOEV6D
lM3gnJGQLvVxUrmgbO/y+vXy63I9PLXKXZGYZBTLvUizZKltj45i62TnxuA1Tc0t9ZMI0diE
MRq1gDWKfdgZRSfQLYqlKGOkgjVL0ufzyTJfBczU2+H5wTt9s9bokjaCXaGVAFl3QRj2f0O2
JObsTaSwSeRjxHhtu/z4dDhfXBrmFG/AeAmokLdM46RcfxFGGiWxvlQApjBb4lPs2Ho1ioLw
FieDBV2ty4wwmDkCS3ZqqiNuzS3NCIlSDlzlSW2Y1vBtEuYxR9md03Arqo7x4TT/m+8v/3hX
mNfbgwyX6/568fb396fX5+vx+bulLxhQIowTmIvGK+0QMl+YKSZwAgDP+zHldtwiU0aNX5oD
6lOGliHx5VIr3fwHYeWiMpx7zLXf8V0JOF178GtJCthYlytiilgfboEQ2zDJozJFB6oDyn3i
gvMMYdKIV63YXElzbjfqB+0kb9YE+WBTWpBIhGcMwEHQgN8OZ60d0ZhvwF0GxKYZK/Wx+x+H
h9fHw9n7dthfX8+HiwRXIjmwmm9fZUmeMqcJCncLXgTswOU61wRv0gREEweEJ5lh4wzQvvT6
kr+TPbjtgIH5gKVjxInvJMpIiNwHZBluYPBWxovMPXiZJLxUP7tWgMskhYNNv5AySDLhLOCf
CMXYWIpNxuAHB7c12pIyp/5wqh2kNGh/UUbb/m7RSncKAScz1LgiPAJjE7qCaBq6TF5qscK3
7ALlmA2/kzBaODyZYWb6AIgODjoSBqBTc7uXCCJNkDsFDHLI0zTBxK9lSvXhJE3ca6OrGIWB
r9NK+QPfJZiIJyYxW0Nsd5oGoomDBU3KPFNesqX0txRWV2nYpTmYY4myjOphcCNo7yLWhZTG
PjVQqUJh7ZxuiWFC2ua2CgcwnJsQQqdzecKQpFt2amqD9ewPpCe+T7R0NcXDwU0djqt0PD2c
v53OT/vn+4NH/j08gxdH4F+w8OMQ/3SH8x9HtNJuI7V5pYxSnUBbb2aYL1XO4kSLLBVxSCc2
PaPR0mViwNSwmDBZ9o6Hnc5WpI54/WQBxO6QMvCMcAiTyDmtTrZGmQ/hyDLdPAggtUsRzAi7
D9k0OFm3A+AkKn3EkaglaECBkpqpEETzgELFsHJmMGaxUPNNUhJnlGkRUmQSS2EwsU+RlpVG
kRYb6xRvvSOQPJlpGk3SJONlhDTrU1EUEsogRCtwZHkqaBwpI8u1vJdBqr5RQzsjRG4JUUVD
SONMz6f7w+VyOnvXXy8qGdGiZb3obLgph6PBoGUHuSkEs3KXUU74GqLZat0iayXJkgbyjdLn
S1G8qFTtcX+5eJR69PlyPb/ei0JWn6seK0MHjcEQgmDo4K3hw6G+rQ4KCCNOu3SQ+nTrNAe3
2JplRu54Dun0cDBwhcYv5WgysFLzsUlqcXGzuQU2jiWBZbEUAnNW+qxwDDTXztbIT3blKtVz
Lxz5sqCut84/fH39/h3yU+/0Ym3bpzxKyzyFojaPVZD1IbZjklaHzp6UgFwNXsRUlTrpSaNj
thr1ltUalf7+fP/jeD3cC9THh8MLjAeX2xWfETAjbeVSJyiDIlkep3WSbLqHD7ZclkolHABI
W7UeiBgomhJ+hCTrPJbHpY8EhwRlfUTj0ZLyMgmCkhvOpVwhviaZ2GdwqCstOoY8qcurmjzx
8xAKNgiAMlMREVULbCsuapQyhHATsttRs/0qdigBRIZhehM9OrGmxYKT7cev+8vhwftHBbyX
8+nb8VFVYG3BDWTlhmQxCd3O9y02tod+Z5NrmYWPFWkW0fZZ5hcsEnnEsJWuUldPgg1Ldxwn
xGLNS+Wx6kXBEaTiSIhB1r6KvZAdGF8SCQrWT5LtagKpRvLzcP963X99PMg+oidTiqtm0Esa
BxEXm62lNGFQpajNBmcQt8XJrctVYRydEqzixXBGU94BR2Y0BJaCo36Q+4SVK4kOT6fzLy/a
P++/H56chxNiIIdsUsuWAQAWDgUogM3AydIQjDXl0kAhNLPbGysZwsLjuJsLIqnIiAiPVlJQ
Z4hME6JWWQTzgxJiSIn97PZmsJg2sZ3AxkF5I1OEjTZUnHd12I2SKkJOsb6kSeKqA74sc81X
fJFWnOAuRKQF2rZJjyWXKlzbxuh+gLBCVjGAGf2xPO30OZvt7d9BrWgm3Z6Nf/j3CEmwfz7+
q1LlJs/GkPkZiRqOMEUdBin+eL8/P3hfz8eH7zJfaX3/8b5i7CW2OeXKb61JmOq1iQEGBfG1
iHuNDFBU8yi1+4Jt4hX7KASf29e1krwDmkU7BGdOtno76wmO56f/3Z8P3uNp/3A4awdgV4qa
Rpe2Acmt9EX7Qy+qYWub2bS2cTtKlEKtChpJnQRlAHa0RNhdQrRDxPHKCHM3BO3FaaUkGOlO
Ni1q5+GcR9Y4pZ9BIZi9RUC2WY/rVgTCjis2cNijZOvqWzT5NZwG4EixHjQysjJ8jvq9pCPc
gbGQRsu8M1Z4fAcs6gJ3ww4oimjSnVxvctcMITL7O6p7fBtTRkvHOIyXmp8TOQzUYsrIAt0I
BSogMVauhOg+v+cQSjtfvl68B3n4tVMZJQVUErotRmsKM7qtSWfR7FnMDKcVcVeV73Ntl5JA
/1lEbS7MwwCKYMOhJjWAkK+Fd27UJll+MgD+XYwiaswqYwVhzIAZW5iIJA2O4BbUbsQ+hUjC
rTkrmHEWojvNlaOsqvO0+CZBJSrm89li6up2VRTD0bzpdMTbiHjs9eXldL7q/QwDrkK5uLLs
bCzyJ6NJUfppYgijgcXJcWVUGoVxXsBFRHemuihmi/GI3QyMShBMM0xYDmYuNElxj19Aqc8W
88EIOftYlIWjxWCgNfsVZKRVw4zELMlYyQEzmTgQy/VwNjOKvRojJ18MCnfZF+HpeDJymTEb
TucjLSEHS4QFlgSn46q5a8yWIVfDpRDtj6JkfkD0HG6kdwgISbMk8i6aBdTqlZgS8dGNq/HY
YCdaZFLAkKwQvjO2SiEiVEzns0k/u8UYF9MOv8W4KG66YOrzcr5Yp4QVHRwhUFDfGGmquVB1
63b4ub9UJf+TbNZdfkAQe/Cu5/3zRdB5UJMcvAcw/eOL+FE/Iv+P0V0DCSkbC/t3Jx46Uc8x
CjmBbABSlNRolhK8TtzZyjZFMcXuXE8/4uqWBTNaQTQbqcUDpKimdDW7BqgL5OeX12svKxqn
uZ7Fil/Bjnxmw6BQBocZEjMYKJy6/d1AkHMddEkSIZ7RYqMCvJQrvxzOj6LFcBQd2m/7++oi
yRyWQMIEmUIv30/JHaC7IpGtNaqDt1q7mq76Mmg1ckPulonKpOv6pYKAa8VOaDqZzOe9mIUL
wzdL1wyf+XCgO0IDMXMjRsOpCyF6UJvSp9l0PnGgw41bglUq06RGnQaiFHcrPZdrDSHHaHoz
dMVJnWR+M3SpTNmRU4Awmo9H47fYCorx2Mm1mI0nCyfbCLvCV4tOs+Fo6OAZkx3Xe3QNQjTr
RErOnNMxnuzQzryG7NDksXtzGNRSxDUlnLsbB5xHo5InOV4DxClNIezwLVEwSofDonDplG/K
1EjQtCOt99BEOyZlIwcInGzKXPDlne8Ch8mKwr9pauSrDZpBxphCOHdeq3WpSmbWGC0Jvksz
yxG2SFn+y7tq5zFoCUmIYg7h4m1poMAlodSiay65d/S9mQLxOur9qVzLhQyPorA7O75DKepl
J5ZmFm4m/E1cLYc145YVRYH656wckyl9s5dqQisIQPBg4tnKG3FCtnDd+q0IxBYwDOVK3B/8
jF6egs3naTSfDooyidXh62L7kMifDW8KN9S90ArXl+5URBn9ksSoXHcPiU3JIxKKoy8X37vs
ZYSGerCqIu+4GEAByrl5a1inCcVsNp0M1MLfyCaK+WIxq0TteBg8HM/m4zLdZc08JkEE4aUr
mYxgS8hX9WJcQ/kEJ34PbkuXGbIxOAUdGWJYy90U/NPiDUVnZJWH4iq2WmmvQnjKppPRcP7W
ZLn8p5dFisIIsX6lpTiYT2Y3HfAuanVmzShwUjG9k2ab+WAi5nSYudRrlohHa6LkrFRvTeGj
2Wg++A8266PFYDLq2pWDbDp+x/yQX4Tjm8J1ziSip2QwaZj5LEUh6Wc2mi7cDeuGYjqa9msU
R2g8GAy6rCvEm7L52XYkfFKlTntHJHo6eRs960MzLtKBoe3TsojelOYFigSZfT8BsTSmYJHr
oYVEBXpzoYbIgJZY8JFfVXw2/XDYgYxsyHjQESoY3zh3sEK6Nk+hJjc298mkrpfW+/OD7PTS
vxNPFHHGPauxKPmr+L/5VkGBoVYzkkcFDelS5WBaDSzgGdq5noFIXFUCO8cBMLKerZhjM2wm
fRU4dYuhigvmatnk1uJXKCLWq44KUsYMyi0HPDQaFi5FNy+VXcW0Klt/7M/7e6hku606zjVz
32qCwT8sCWWbN2ahfEjDdMqaoIWtd10Y0LVgcX3oG5dPeUyLBQQGfqc//5Sdol6gun2+HU2m
7UaEvnhgIF5Z2g/BVMPicD7uH70Hu2hWCaTq7GI9qlSIufVaQwNrzzXlq0hYYY891QOG08lk
gMotpDIoNu/adLIAknPium3WiVo9u2WLXMdYp4izMkcZF1elDmwmnkhH5C0SUnAS+9ZLLQ0f
oRh2Cwy45/ZMI0UsFbemWzHbu8TyWkI0gt+l9AlUFfw/kWbMHdUMdrv32fDRfO56d1MRJUGZ
wkkSb2ubTvvp+aMYC9TSRGWD0NF3rThAbjl2Py0yCIqOJQvdhpSTXkT36NoEjckMLQozPmrA
Xp6MBsbbTgP8hnEzjOPC1cdr8MMpZbOicMvUoPsxZmTvYK0oX+GrWPOJo9V7NlyR2mQmUdWi
T5mk64hjonuVDFHMJSvEtmpEvwCCCLZbHt/OdgcsLMPUKVmL6pVKktA4CElRsbAltCjelxZ+
IwW41NKnK4ohAmQOa7RJDCur29RmmLCPFuZZ2GkxVsgYuMkHAZmrIxXnYWhG2vUWVxfSDmbi
Xty6BW2jdfs8vQNTr7lum8coEmrOEKYufbb3AKm7n72lGYS47qZSyJq7Xz5JqPB08i2uDRcX
DeodmRPDeGakCBKl7uNLuZxAXTvraP1LHAUAV2JUGQIov4DzE/ejaSVBsiNZEgR9FMuOIO4r
vF3/e2dgoO5223f8GP5L3Y/z4aiHd30X4t2sTsvm5fyQvOWMy68/1HuN7qUCFFzdexfdB4qu
l2yawpE0LF8g1HNBV8kmkPI199ZkFeVFHfui18fr8eXx8BNWIOTAP44vTmHAHy1Vlg0sw5Co
l4+GIMBWUvSIotBq7s64kOOb8cDV868pUowWk5thZyUV4qcDQWPhLlzTZcT1zkxgfWIOtQZG
YYHT0LhYe1OF5tTVux6RI/dMX/c2G8NAj99P5+P1x9PF2o5wlSwpNyUUwBQHLiDSRbYYN5M1
lY1459FaQWul8kMy76t4BaIctPfH0+lyffzlHZ6+Hh4eDg/e3xXVR8iq7kEVf5pyY1if1YpV
ahef18hHWvbnPBYa6iDn0yGLTEvyNAI7ctSwsv7a9xOkq84PGwRlUt/KaDDQbM9cjEacWIdY
pQ23zWtScBzPEO0A9TfsPKh1/7B/kd6kc7co5kJWwS6AHCUMXHmTzSbXH8oQK47aZpncAkZt
m3Duv7EmoXxrmQJU3e7bqlU48bRHPPHp3TT5DN256wIj7NcdDBqSPu+se1Zt3NjV4LLTypR2
P+/RcBFiVliXUPMDL1X4ptSL9hexq/j0fD2fHsXXj53LYzFcZaZa5tTA7GRaIAoq/wVXbHx9
L2DgGZbI/HJMgnMuYmbo6lwKPIb4ZH1wqPRQHyt3Wg0kYEy9OCgXSpFJWrcLGoXpDwQkjGaD
MgxTWxSRmPbzSbD8zNZklSV4U33MbrCCimJO2XTg6hlJvF0gif0t9NsEASnEp94WqD7kGuzL
Xfw5SsvVZ4eZocjRLRFGowUWVzkq5MkL59D0fLqe7k+PleFZZgb/WW8iBJSHZDoqnHWtGGOe
/AZkfaDQwqsvwQDOsyQ0KTpP86o3mG32xlxbnKZGxwZ+7R5R9UI5Zd7941E9/bGTGTEMh1Q8
DN7I7zdbMTSU7GY5MR0vrOEqQ26EqP7syOncCacpT0HE0/0/NoI8yxf76fpO/LUH8f4lJlz8
NY0SQFLbUOREqXgpfz3Bkg8eOHyIGw9H8dQTgonkevlLfxDVnayR3U506he4FaJUX2Rri6Wx
SuG69CI/CvIYW21KwQl+ck+hENZT4WpulwVUUiE2no2MNnCNkfczriNdE0Q4HY3ZYG5m2B2s
8fLRxnYxDPbD+sC5xhTDycDVkGoIeBQUrpHqwu2NkfJyrCtLgkloPvps5KcYvCH4wpLZibr6
ywdgrpf9xXs5Pt9fz3qztv2TAj0kthAhzBOjFcocWhRVEOrCMbuZhXPHgiRiMehDaJcEYlVw
bDoAyO8YF98WVH9QZjJsvrZKAiv81ENo9tkOG8o8e2ocmUfKD+BNXiU2CrAGVG6HFrT9KxD6
JzpP+5cXyKvlrJ1ETo6b3RRF/Ty9kVViVPLQJ2wb7nWov0PpssMp4OKfwdD9naQufpMO9027
yroKL9fhzu9MKt7r4K37b+lIgmg5n7KZ63Sp3UARmvgjsJdkmXe4qwD/xk5i/TpCAu3QrpQc
+WVQ/a0e89sc19Y1xZSEHn6+gIuvz5jBVb0K7BMP+XHaWdFqB8p3v65T6hLP2Ho+dW0JRu5H
0eqKTRTb4/cIZq4sokKLRwK2BnlK8Wg+HNj1iKUidSoC/13VqYcq/UIu/dlgMpq/RQCLGEY7
Vx9OHRL5WsBaRpiOFzfjDnA+m0wnnb1SXvDtrRAvXd5QdV98UPZbPfUzx9TvQPpGSfxiaK/s
/xi7lubGcST9V3zamIndiSYAggQPfaBISmaXKLFESlbVReFwqaccUWXX2q6e7v31iwT4wCNB
90UO55fE+5FIZCb6j81ZJA7xrhGMW32G9M0kkr7TZ3INIwlmzz42BiMZOSOtCCOaBL8rGBMi
cgre1t2+O3hpnQ85iSO20CXKVwY9aSI1VFU8Pb68/ZRCmbN6O+N1szlUm0BEhSHn4sPRcu5E
Ex6/Ud5LKhvyr/88Dud57yhwR4ZT7KXsaCwsccrEyB22lM8crlJlRrpNjbYWUiqztN23+z+u
dkGHs8ZtZWpZJnrnqHMnACoWYW4NNodA0tTABTzMwQcvmDzBLIrtVJLgx6g5ssmhBTz8Y4av
DTYPNjVsDhbOgF2KA6YrsblEKAFc7jU5UnNu2gDBAVFFcQghqTlD7MFkCMNwwaC8vDCNlEYh
WsfWsng26QtxXyy227tmjxl9tmWuGa0laJCe8rK4rHLQ0+BmaHrV1d+jDMrR0oMHcEh5si6d
mxJuCjagnJZyR5QYrT9+khe9yGKem4UeMWXIiJZm4rijEeGLLNDtCT6mTRaBCRcWA1J4RadY
0bsVHlBMt4ZE58SaXJ5oXOKYzuojTc/mtbYDuIa3Lnxb4jYSLl/ZX45yAMlevuxO2MI8VdkR
UcYqSbpldWvwo3S5xZI0iiOs8AOGnbctFkqQkRYeg8p817TOGwEQpmhqlmRE3EOZxzB03kJf
b3uWcIIlDrdTJKF4MBuj0CTmabqQgzaH2Q+8CU+wzDDBD2ufDG0HOUxiwnEB3eShPH2XJ2X4
hDV4uJMXwiGyKFBQngl8ups8yXkpg65ZsRhtiEHSxbpjHJqb/LipoHNpFhNseG/223Jdd7eL
hTz0clVcbqhj0ZHIVjT7dV04k8w8WZbxgO3ojvcJGHgHVn61Gc0zSv17OdWlSxquY7TmQ9tH
3b9J8RKz3BtcacuUkdhSJ89ITDCh3mIwpK+Z3pDI9JqyAY5nBlCCNo7Ng1vUWzy23ITyEHSq
GxwZjRGX5Lzs0zPBfZIlxAhuWTZzxCSQakzQBpNAQkPZxSk+A20efHRPPLd9QC00cXQMVQnM
eJEmlKCFPNeXdb4b7xEWEwETRjSN/twu92chf/IaIsYc8F3EZWy740JRyi7B3NTBeRyv5eB8
IGW/hVTXKZHHgbWfLgCCrjcYwlnKOx8YXWAsj9Tpq16e3o49yBhYYTdbTkSHBhKcOWhkBu2Z
ACng5WiaaYIvjxODvqXHxOmR5ba+TQhDZ1a9avJqqcSSoa3OfoFrUE3eObGcJ7AX+CY6MvxW
oKLRCMul+kAoRUsMUaykvLLwNaJhnyC1paGrpIZS18sjyBe4bDW5MrwCClqqvpKqOLJmAUAJ
DwCUBoBghWOaLK0+mgMpB0hphKATFiC6tP4DQxIlSCUUQrIAkCC7IQBK2vPpjDj3YDbGluoN
QR8SbJNVAMNLmCQx0v4KwAJwKCBc9gz7pGgZuvf3RcJRMUOKepSJZHmJbw6pXJQwfcu81xXn
MzqEmmTpO7BVQIZkkzKUio/SZlGakDAyLraNQDMWaMYCm1CNSPHiZMs7umRYnNpNhpYh45TF
ASDGVgIFoC3WFiJli/MaOGKKjL1dX2hVYg2hwrHEd0UvZyKuCjZ50ndEI8mTCtzCxODIInRY
79qiSdHTz1zDteCZ0W6t7aI98bke06YcSxPM7NLiwMfsqtpe2nXAJmjkafPLoUsCd06TwNG1
F4YaJc3b86VYr1ukbvWua4+HS912LVrF+sA4pctrg+RJIoqpSg0OESVoN9WHtuMxegcxsXTb
REiBC59qlEeLXaB20lSgH2to9gNeToYJgvYkbDAcv0Zx9jO0BfTGFb2z/uZnGr27IUkWTCLQ
uwW2ggESx9hBC5QkiUCbrWllqy3P3LZJ0iTucRXrxHSu5Fa+PLY/8rj7jUQiX5Zvu74ty2Jx
PZPbXBzF+HYvMc6SdPlkeyzKDI9mbHLQCJXnzmVbSWF14ePPW9kWSEeAl/c6RyXobtWHDAdH
Dnm4XO4pyfHO9JYc7M/3OIrlNMqmkuLUsrhfyVNVvChiSA5KImRrlEACGnIf6ZquiNNmAckQ
gUxjK4aJXl1xC1o15JEai2NRvFUcLEES7/su5ajM3DWNFBKXBTBCRSlwjVCXChoCUlx3IBtV
LC/ru5xGGbqqS+SMq1ENFkYXk++LFBdYb5sicLM/sTQtWRQcFAMykhQdaSdJj7HxBXRcKSER
jt5ujgynnlBM53QnWJoyRB0BgCAlDmRBgIYAhhVbIUvDTDJs5V7SI8KEhhLHcnoG5aS4XS8n
LVmqW0RJM1lLDHQlgOZbj6CiANedHSBhxCr15sMOnLAHN6lLCW/SXJruVyMY/cjuXUB6HHvc
z2qE4Z0BFaO8P9SBd3lG1jEu82Z/klWo2std3WHqC4x/DSo15VVstjvGqcLjqmeAFpL2kkTw
qYhYjsAA9vPq552M5hJhKVXNUfvtL6RiB5bVBqz+8DDvhz1wdKvzKY7jwETe7e/yT/ujZSY6
gcNDburFomqnHtLCLvJHdghYpiyTIb3Ig0ebSHWZcHf/9vD1y/O/b9qXK7zD9fzz7Wbz/Mf1
5enZsk0ZP24P1ZAytDZSEZtBTrctWiWHbbffYz7MIfYW3CKXMzdH6chu1zgUNrDbr3ukBy2y
kdPMMVwZId8O+mQcSFgIsL6wbZQwx82xNbRFgp/m4CTtA5/r+gBWG1hug1HqUoblHZLmeP/l
I6CDYuczmtsYc2bRL7WRwzunkqlEHca7Fbxm1dUry9W6W1n/XLqy3sOzkTjvBNvUIV62bS+7
KpocSQXIZtUUm8qx2+O6XsUxZtHkxaVosHXKYvNLoi4MfzX9SX//+aTeaRnjoHg3h826dNYl
oBgGJia1Y6kpZIw0x/y/UUtjyznF5Sr1Wd5TkUYq6zCTil0G/koF6jw889xuC/P2BADZIDyL
TCsQRR2tSc0Sq3TOLY1C0aCAwTWVn2muOYmBhKK4qVYHi/nAgWrCGSY9Tah5Cp+IpiJ3Jvpd
BMsMQ70hRpRTt1rDYobfRBgMSIsoJFQbveTZ5dbro0cjdgwaoG7yvgK3nO6y6YLdVxB2tnXK
BnmhRiMH1sktTewbbAO8rRMpzI9hNafv5OlW7kldXWDSPIAyn9Gr2UhNhRLDz0AAf6gax9rc
AHWAQmdUaCJHiJYZkB7L2prGH+NgHUMxJcYM88hLTFJFgieW4XreiUHEiwwii3C1wITT0AhE
7HhmMm4KovA+wTXfI4gkWe3WlKwafCOoPis3ekwiUpMZMDfFXX+u8NQAldLKMQi2xZrLWRZu
1UPPoyW44D0X2FhW6Adhnn8VScsGbhW6qljeC7o6TpOzx2NyNNyOfT8RQ25CiuHDJyFHt7P2
jBb72mS+bx4fXp6v364Pby/PT48PrzcKv6nHaNiIIAkMTvQcRRqdTkdj9b+ftlU+xyMGaD24
rzLGz5e+K3J3O5wcIqzmASM+ER7dPXj/YtYVaugonwfjSNd2CYn42abI5rfWa01Lw0uZZhC4
8dDMkIUm3Whs5lYV6iJri+54Bs4TZ00c3TS89IAukncqkqE2RAZMkdwkFdtuJmxJqpBMcq0P
2Ez1d9s4YgtSl2RIothnMDK42xKaMkRm3DaMM2+E9QXjIgs2uuPMotLxjSmUgKY9iTy5bYiE
GxbcRg7H3XsSjdCnG1RNG04ip3+ARiKXhu0cihqeWhKOA1dxA8yIJ45iLGHJxVVzzTRsdKny
hprisL9t4IxLhCtQjwicft0k568CxpQGkxTLz80RU+jp9VidDb1Feu0JdHdFmbE4PCvl4VKF
TV1qWQhntL00JLp4u7QZaCZ0tpqOweNNoFnGOUxwKKTFzLGuzxAIcL/tc/Nxw5kB4lAddTyv
7mi5z888oBRTOjGTCymOlP02znKG8QySJJ4ACI/YVcXMBAdLYbvg2SCcOpdTKDnLRCCBYapv
yz12F+AzykEFDiKB1NRxdzmd8fTrIf7x08Cm6YJBwxxDCoS6QiJ8nguIP/YchwQbScIIC4xl
eS4L3PxZTBTdDh0Wguexznec8YB5t8MmUM+UmcnWnRihu9WhDc9fYyeO3pvPbHW3zVgUGOFg
fUBTsjzCzQ0QSQMkuXR5WCoWtBOV10ZgeCnxBzsfOSyh6bvVe/1yApInSROsaMYxE8W4fWi0
wJCXhsUkkjgLJC6SJLCqqQMg+v6Uw5OFCj4ed3FMRHShViJgRG+waevhv8ElMtzsweRqiWzH
d9la7rwJgzIJwXEbCJspIEGbTB/TDNUyGDzypB1aNxT23qoBTKgHqM3C0UV7Oud7yHRGQrIE
9/w4cPVscK3FOSAnmkzHzxV5n+0k10VUW+HwmLaMDpQF5kmLeibP+Mdi33ixhRz42K0uJy+A
mMd7yLt2VR0OnyBS0vykxwXef9thpmvGp7ZCwgAmtYQPSQEVL/Shj0XA1Mpkak4BRfjMNGoh
FgvfbTecRCHxaxCR38tI5hMleKwDi0vQgBDtcKX4pfbMBeZQRE6u99mU9mCxBYCJstBSrRUD
78ziUf+A9bTCCAssyAtebB4TOpA0Fgd23/F0v5j8yY4QNQNGAAh8bm3zVb1C318ovIB/koS/
D7et7SDKq3ataPDAXRXo4WJ8iyUwrYvxdVkkv6IqHEUDUHb7vl7X5mmnqco6V9ihwKgg4zsv
gaqkb1OGmtHpL5GvLECezyCmT+CeUjOuysNJBRntqm1V+C9AN9cvj/fjAfLtrx/We7C6/Hmj
bpKmwlhovsu3+82lP4UYIMJzL4+IYY5DXkKMEhzsykMIGmMLhXDl/G624RSQx6uy0RQPzy/I
04enuqzgUZ+T17t75YtmxVsuT6t5SFuZWokPQUG+XJ/j7ePTzz/9V9d1rqd4a4jSM83W7hp0
6PVK9roZtkzDeXma7mgtQJ/0m3qntrfdxgxtqtJsqobCS+9WEyhkfQfPwJt1xepktfAU+XKu
sTNw52aF1gzOEIPtUH08QofrWuu4et+u969X+FL19Nf7NxUf76qi6n3xS3O4/u/P6+vbTa41
WtW5rQ51U+3k8DXDngVroZ9Uf/z349v9t5v+hNUOhkaDr20Kys+yj/JWzuruV5KY0BAnUfdR
Zw82Hai4q1S4PXl868AjbGPzHLfV1PVTVZDCmquCH6NGz9WxiAv9Auak40McY388PH//Dtoq
/R41PtpXxzV1ltyZjswERZcDc2/6AxhfNPC0uXkJ0nSXrs53+0tT9nbcywlB45wY86tvLbsR
SZvXIm0bgW81wDjNI5/P6Cw3OaucckVcyk53YFP8AmYkNzB7hkDC5u0Q1BV6Uu4O1nQ2n2Z3
G1T+NtbuO1Ll33CD1bK+2EewJeMaUGgAsxi4AtQaocagvX96ePz27f7lL2z46szrg6t9VTz5
zy+Pz3JfeHiGmE3/c/Pj5fnh+voKATsh9Ob3xz+tNtRp9af8WNoxjwagzNOYYZv7hGfC9FWY
yEQe5c8evYKHUDnS/gpBj6cab7qWxbbQroGiYyzCon+NMGcxd8sB1C2juVe+7YnRKK8LylZ+
VkdZK4b6v2pcSo9p6uUFVNP1cBg6LU27pvVaqNvvPl1W/fqisWmk/L1u1TEvy25idDu6y/OE
Dy4kY/xLk33ezc0knHaQ+y84buOrg8GBHSFmPBZe5YGcmNGQLDIImxgkYk+wGMjYF6teEK83
JJEnCDFJ/FHwoYtwR9lhoG5FIoubpF7P5nlqXXqZZH+mgBIwta+abQQqF56Xp5ZbL2YaZI7M
IgmkoXgeA8cdFRF2sTXCmY5v430m6biWa2YIOByNM+UsjxdLHFLeyKh91W2MY5ge99bs8Ue0
6oTAbfqwYpwplwsduoo788XI+/oUnIYpofgQEd4KomZTivSaBjBd84wzM36jQc6QzgKAo3c1
I54xka289D4IYUcyHLr2thPUVadZbTa1j9Fmj9/l2vbHFZ65v4HnFrzGO7ZlEkeM5MgKrSBX
j2tl6Sc/b5u/aBYp4f14kYsrXEqiJYBVNOX0tvNW6GAK2gSmPNy8/XySYqOTLEhD4CtIBr/U
0azF4dcCwuPrw1XKBk/X55+vN1+v334Y6fk9kLJAAMhh7nCaokYgg5DhH846eN23rctB4z5K
MuFS6WLdf7++3MsMnuSe5T8YOAwkKWnv4Ei89bv2tuYc8ykdytnIxov9rxQd15/PDDwsPgCc
BtJdarYGonuinzEWXkQB5t70358imvsbx/5EkxhZFIDOseujGRZoYv7Csz/xQBaSHl52FJxi
nyWh8K/zh4HwPQbDcsYZxzJOKcd1uhNDGrALnRgSd/X3GNCIQHMGeEsKsTCs96cs8aVroHKE
Spjgws/j1CUJap0zrAB91kSmH51BZp5kBWRCMO5WLskIucfT7gmhflElcIoWNiCFs8CHZOHD
7hCxqC2Y12q7/X4XERRqeLPfdn5ehzIvmkWBRHOES3P4jcc7r1U6/iHJkU1N0ZfWcMkQV8UG
U/pPDHyVr/2kq15UH3CjovHLImUNvp/iS7pa7beS5jtJjEIEF9Rr7PxDyvyzU3mXpcQ7DwDV
jCozUUWUXk5FY+5LVklU2dbf7l+/BnegEu5uPYkJjPISr8ySmsSJmZud9hQpenmT3nQkcWNF
GUGY/b1UqwgAyz2dSHEuqRCRfpTkcPKVt9Znjqr5uFMKYF3En69vz98f/+8KajUlhCAKTvUF
vAvVok8pmkygEhhevsVRQbMl0FQm+OmmJIhmQqQBsMp5mtjGzh6MnfRMrqarrRXOwnpqu844
WBKosMJYqFwSxSOcOEyEBav2sScRblJrMJ0LGpnmVTbGnStUG42jkFWmWcbzVqbCwwpYky31
b0Y0WsRxJ0y/cQsFodq2tPEHDxo83mRbF7KLA32sMBrKQKGoXb9fCopnUMVRFBgn60LKrsFe
aIRQgWoi/O1YqwTHPIvQaCn2PKeEB+ZS3WeEBYb6Qa73yP3f1LssIgfca9sasw0piWzOGNdS
eKwrWfMY37iQpc1c816vSuG8fnl+epOfvI4PGSlz1de3+6cv9y9fbv7xev8mTzyPb9d/3vxu
sA7lAf1v168ikRnapoFoRxXRxFOURX+ajTSR0Yk6oAkh6FeJIwzZVzdyQqFRmBQoRNkxHYgB
q/WDeszpv2/k/iFPuG/wtm2w/uXh/MGu57haF7QsnRaoh4lqlmUnRJxSt36abM0qfWl1Wv2r
C/aLlURxpjEJNqxCKfPy7RlqWADY563sU5a4n2gyfgBVtea3BFd7j91PhfDHT4SNH5pl+EjA
V+J52IVx2HkjVI87dmYUmVZ54zfU3lWBfKo6cs6CSQ2LSOla5syg7rKFsshcz/6neYI/bT6P
Aqf8mpgiROo2uhyy5vauMuzkpunVQM6o0IaoBtZKJDnBtvS5mdPpBQwY5v3NP/7OBOxaKfx4
pVHU0PyXNaWp3weaHBr9ahibh8Vh9jtzfJvEViz7uXax04y7c+8Pcjn/uJMHzC9myusq43oF
zd2svG4YAExvPuAp4F5yQG2R1NzgU+7kgZphwgXA+TqTooGdVVWgOwNLvOEopXwaHfxekvSY
BKxpgOPQb6lAba9nlPrDPHEWoc8lkbs2XNnvS7QQ9vXQNG6LYQMJjlhYJoQ70XRLUnTkUOa3
F1VmpFqv23cyz93zy9vXm1yeVx8f7p9++fD8cr1/uunnGfRLoba1sj8FSyaHJI0ib4XZHzjE
DAo0KKCOKRyQV4U8UAa3n+2m7BmLnCkxULmb1kAPWCNqDtmBwT0Gpm7kyCj5UXBKMdpF2xv4
9FO89dYZSDrYNFIKSZQ/vX4/rCv//qqWUW97kZNRvLvE0si3MVAZ21LDf71fGnuiF+AGElob
lbQSs+mN5NFaxUj75vnp21+DJPpLu93a1dXqcG8/lDWWu4I7U2ZInaa1CqIqRkOfUTdx8/vz
i5aXPImNZedPvzlDb7e6pRyhZR6t9btGUUOtA64cceSkrYh+QpockgBAgeCJbNtNJzZbTGM8
oe4OnvcrKQMzfwlKEv6nU84z5RE/uZmqgxfF4xKOKz/zinq7Pxw7Fp7FeVfse4qpWdTX1bba
Tb7WhbZRmr2f/1HteEQp+adp8YWYlozrd5RhNwhaeLDufUJHJpVo//z87RUedZWj7vrt+cfN
0/U/wbPCsWk+XdaIuaFvC6MS37zc//gKnt6emWNpPqkl/1H3VZdyVWPUzjKl/3/GrqRXbltZ
/5WDLB6SxQU0tIZ+QBZsDS25NVlUT94Ivr4njhHHxzg+wX3596+KmkiqqM7CQ9f3keI8FqtQ
Hjcwpt2Ei4o4ofzlCZJwKlFqHxqkPClSVP1RsVPJsZYaRcdylKeHBVLTIiKEFJW867u6qYv6
eO/bJCV1riBAKpQmZyNd6qcGsL4k7aBPBtOn+rmBUCRM+Oblwg0Z3SCBXNQs7mHXHfdp3pZG
Z9pjkdLaCgge0akyWvYxFI4Jw3A8QzW0GZ1dUY4Xy08wymmHr1IE6G49ymBt5+vFPni7L2j/
fRMBvYDj+eJeVmRZgao/wa20DeuVtpTOppfLZUksf+pyTLQmeIEiUyVtxFq0MJXFZU4gxSXW
AjSsEjbHxunqx/evH/9+aj5+e/6qjhUTtWeHrr9bsGK5WX5AvcqTqJjEpOXQOlXvwhKFn3n/
wbKgwZde4/UVLPu9Pbk7msMc6qTPcnxB5gT7mI4XOd3FtuzrueyrglZKWegwMkDT2/zqWHRE
4PWROEFKijxm/Sl2vc42GAdZyGmS3/KqP0H6+7x0DozejMn8Oxr8S++wSHB2ce74zLVioqb7
vMi75AT/7F1l0bcm5PswtCOSUlV1AaNmYwX7DxGjKO/ivC86SE2ZWPrp8cI6ZSxmHPbRluGq
WKLm1THOeYPmIk+xtQ9i/cBvXWMJizErRXeC+DPX3vnXfx4EUp3FsD0h58al7lnJz1DyRby3
5MtbKUoAD7Bvfa++WlQJx50XkGudmVXhK44ihC1mVqjP9iROfWGYetGJTCdBFNv3A2e7K0tk
2MmuxtCBVLKqy299WbDU8oJrYriGXwLURV4mt76IYvxvdYZGTxmdkQK0OUcvZFlfd/isfs/o
lNQ8xj/QfzrHC4PecztawXkJAn8zXld51F8uN9tKLXdXmfYYcyDDu7rNPLTsHucwKrWlH9iy
+XuSEjoW2azaujrUfXuALha7JGNqmtyPbT9+QEncjBnap0Ty3XfWjTQRbaCXjz6LFN3MiJkY
G8xtkyHCkFk9/Nx5TpKS9x10MMYMo9VMqlOIkFzwL9wkP9X9zr1eUvtIlgGsOJu+eA9NtLX5
zSLbwUjilhtcgvj6gLRzO7tILMPgwPMO2gx0T94FgeEJpon9aL5S2OGeNrYg0VHvmUW3nbNj
J/JhyYrq+R47lXTOuhiVuaEjXHlGn3Yt1Ab11S0n7GAQIUtzZOzcskuYmdEcFfVeCW3PxX1c
xgT99f3taBiiLjmHNXt9w06+d/aGa4OZDkNjk0DjuzWN5XmRE9BKBNoKTk7foc1j2SaKtFia
EGURuGwoD69f/vP5ebUejOKKb3ZJdMNXV0mfR5XvmO6oBA9aD9qPwQX6xuJomv9BVAlPlBvb
FZiJYAAtunBvO4d/wNv7GwlUaeebaXeDa8RePBPR67xMjgyLA03Mx80NrSMek/4QetbF7dOr
IT7cWDRd5e78VVtrWZz0DQ/99SpuhnargQz2OfAnD32DStPAyfeWQ14ZjOjgBUcLhGvgsSUZ
gnZZXqEX7Mh3oaBsWKjqsXQ1z/IDG9XefdOiV6M9ioa2b0gQaeWoNZHUShQ0WAWkzU4fGUDM
K9+DrhKuVk4YpIlth2v+hSXK8GAVRldW3XxX9Sek40FIX/bKtLjZjMF3aMsP026XUBxfDwtl
FjehtzNt5Mgd6ijsWYYHzbFiVlyCc4f3qxdMMiHSX2lpY+N6YFPjSbqKXXLzJMbaqDnS9iHR
mgJSslvoegH1xmxi4P7KUV2BypC7M5ijkzg7g8W/iVPmMNG57ymrzxOlTRqmnLVMAEzknnzZ
K8kD11sdXRU4vFF2JJSlO75LFe8935/z9qQdRBT5Ad/xxnU5TUTp68c/n5/+/ddvvz2/jubH
pUOd9AA79hgdDS7xgEy8dL/LIjmt0+GVOMoikouRwp80L4oWZhglZgSiurlDcLYC8pIdkwNs
nRWE3zkdFwJkXAjQcaV1m+THqk+qOFfd0QB4qLtsROhcHeAfMiR8poOBeyusyIXyWjXFB7wp
7HuSuFf7ISBo2GA8paP3XMDBAyHMITQrxZ7but5///j6n/9+fH2mDrAhIjTej29vjV/idiyM
ERuyphtAxao8lP3x1u08w+4PKKMROTrOMsHFcF0mWrwbx0SIcrxlDciBi+wIoiAOHz/98fXL
59/fnv7nCXbRk4mA5ZR8/gTusaOCcT7ajiDSfmDRqciPWacQ5VwsjFMXOx69UltIg3nLByTN
Cg7BGCyvPSAJix1XzdUDwWMxGlCidgkaR75tWyDJ3DOdYd+1qJMUjbOn4i5gxvQMMW9Yu1lI
lB1XKVcm23wLRbOPv6Ts4jlWUDQUdoh92zJ9so1uUUWbu5Fi1yttbPYPGveUFKFYLQ86SyrH
NcZ4Tfbtx8tXGEfGVcD4pn99oSTupuAHr2X/BIoY/i3OZcV/DS0ab+sr/9Xx5lGhZWVyOKcp
qjbpMRMgdD3Yn0LfaGEuaO/KQEKw27ozeWmhIx+H7o6dErwgUu74totpiheWi1JLwV+9OMCD
0b+igcuRqeeGEhYV585xaAXO1dXfFDevz5XsWkn7IVy6tKqoicqVoE+KeC3Mk2gvWy5DeVwy
2IHjHmYVD0/eL8OlJH8HjXwt6WEvL3yuqNYcKjyz5HidR3aYKWkiX0RViyQaTG4ghpY6ItbG
/FfXUWOdjPPURdwzg6Fk5EFTOdQ8wWZZdSdTEmaLHbpwCm+MP+qK/sLwokRvzQptLMJ3o/EQ
k1HYsV7O6I+lJaoLO+wqnQbjFFn8L/HkU76mm2VyzFnM0NmNuHKFGf9D8qu/0wqbdkmNiGL1
YxDMjpP0xqfGWeO2zFxxAi/RRwl12oaMwSfIkIJV0DI/tTVWe91Rx/NIO0Sl8FKDm7NrlvOu
WO5o+Us0mjRARZT09fn5x6ePMMREzXlWtx6VGBbqaGuFCPK/0lPaMYEpx5vElkw8YpxtlPkQ
+gxTxW1d/CK0qjagQE2ckx7VJE4CX6cjhp4KuwNT3AnmaLNKkXWLLgYvnyMpL28id+cbObxu
Vo6caKzZLPcdG01hcyrReWnshtiIulN/6KILj6mwvE5R5aFILkmx6n20xX/XeULXQMNzf3nF
u+kngAylp3V0/TTkk8bECQRuykrWdavxZeGJFkLl+NalzRGNsFPaHXOR4nnLMGjM6xhhhYbY
Dc0dPdoH/cpWzWq0YOf+DNswsiYRtd3AMZr8XhE3R7WBFij+GxXkZkT8DUQ3yb7CTUb/ZaLR
EoZCsu2wz+jL4xWPNqs/0047W7Z6IstVjwkSsiNfrUsEz6Oj9GWlY1m+c+hPeW5IOnNeCJ5H
p7KIPJ/U15sYh9gJffWhxQzBBicyTS1ImHy46GLueoWswqwCRN4HgCisAfBMgE8BO6fYkR8H
wCMa7giY2u0Ak15TFYYpLQFZtgi5tKqETKFd20oE9WmBgtgPx4mRtj1KIOl2C+ncAbBRbq5N
u+aWGDu6QlzZwPUiR5NRFgGgi2/VGPgExSxwaH+zE6HMifXdcGKtXxlNaMID+0HlAcXZkW58
Z0Lo2kSbQblDlPYg1xzxqJh2YT+vVbvS6Ed9mtAqtFZ3ci13a5iZzbnDsLBOBJoACq2QSLpA
XC9gBsijRl6B+AGVIQHtaVfSyicDYqiZELokZ5THV+On3T19BKkmfavll7wM97aPPj7GWx7y
YxJrtH66+V3Ygth+uNXokBGERNcaAbpQBLgnluEjYBoBJnh7fEFW6BtiB8CcJgR5Q6ziAXSV
l90asJFgAT9aoSAPSnrlq8dM/Acxoose6oxSoTj/R2YKAWM5CZAsJ+jx5FjTFrAiIAbmtoMB
PTT1DUShtQK6mdW283zyoZ1MUN/NywhpV0cmhMTcP8jHhK+wwCKaihAbQ9hk6YDYXDgDGDG9
gAgisd4RYnNyvDnqNc6PXeFZVB55fixZzIkl3ITQjWpG2wT+01D5HTUPGPwtTFxvNomRrG2G
ddK4ZdPFvHRciygxBHyLaAwjQHeJCaTzzcudJz8EnIGOuQ4xhKHcI1doHLUP2NYms2Pc8Txy
QyAg3V4JwQn87UWK4BisPUkc3YkdwQhsIvcCcMjsAwSbnQepQ8On9lZ371K2DwNiOpOMiG6C
polApmzPXjPTtW/kAnQhmF11UdxHM8bIjaObvdtaanTcZY4TJGTa+LCG3/4QkjzqFcbEEEZZ
qd2bcGFG7d6uZejZxICEcqrKhJz6AMhDOp7AJqcQRJytbbuwFUuM7kJOdH2UU5sYlHuGpHnk
llDYrt2qSkEgtgwop2Y9kIfU0nqQm9r+iG43e/SxZ5lysSeNlMoEam0m5HQu9gGdi31AHnog
EtLaUjOFMzSYucn5ULi6k5k1Rxw57n36daW8IQg8YpwSnniIxqN76JHkmn+nCanYOXRJXTWZ
4e2IgkcgpHqjABxyBhqgrWruGubDapGpTxWVU1IlyLAEwJuw+QCUhvXkDEe+x5Y1mcDN92R5
26nec4dLpDxeXzeDcEkA/OgP4jz5DvN2m1THLlPQlilrvnOW06nAiMabo/Vp+vfnT/gOGcOu
zLZhQLbDFxZqqljUnpVZZxb2KW3ORxAa2laYwM54TaZHeUiKU05dZCMYZfjUQg8SZTn8opTP
BFqfFb+oKCtZxIpiFVHT1nF+Su7UWklEJcwOrT5/b9qEm8JAjR3rCl+tLElYZFB2asoSfB+a
6p9APyg19TpNgB8gyWosx6Q85K3Wro5pW+oRH4u6zWuD9ygkXPILKwwXi4jDp8WzFzPhbqr/
Kyu6ulHTeMmTq3iDs0rovTVpOCCcRyxO1KjyThO8Y4d2VXndNa8yUu9tyF3Fc+iDdaWHK6Km
vpK38AJNtLIvkqq+1KtI6mOOPc1YeCU75lEJ9WMqwxLKsF2nrmT3tGA8M4Rqk6EFap0ij9qa
12mniesKhiO9hZXnostFzavyqstVQd12yWnV0VjVQVeGxkfpYApG0rHiXt3UyBro6EUUr6Ib
xH1KeV2RCbPKkSkGqDhzX5hIUW6q96ZglXgIE/HVFwp250YtnWH0wSetejjO8DWmIcj4IEkt
JN4kCarFnjRxl7ByJUoKDnNEskouRNsUZ9Og1pZaLR/x0RvjuXTuOotWYxwvWdu9q+/4AWWK
leTapCL32PxSq/HBKMKTZNUq8LXBkVYtRPiMc2nfcFo9UQxQeV7Wnanr3fKq1BLyIWlrPVOT
zJyhD/cY5tF1J+Yw+KAL1TP9ekVMoUVDuxqhpvj5uTy5DMGLZtFfpcpaZP2xhqlR8VGhx6QH
0r1JUVx0XlhnUa4qISsLHGCM2klE8ZWqc5fm2qJiT1LqHqhV3GjBVLiXOTPNfVkZCdcuq2XU
4K9mcFmTvfx4Q825ydhGrC+rMBbNixWKeAy5J0Q9eiyKIlhWKFpcC94UXVpSANQVEyMABeIs
WakavQuY4r8uvQlZWGVeHBJ2NtTGymE8iM4QMPfbuiBNkAIhej8UghIq4+9NnxDpuMGMWtEZ
qWlnVQuBlb58XV7CoqvLZT29STJX2WiJ98+X17/525dPf6zXzXOQc8VZmsAci37DqaAP20qV
XMVEtKQHfw062XKOF2m/mu0pkpizYQozPJsTzEOL02MFDa/PrmgVpTqqyrmDxeckphRQRAyT
gjRRAwJnlWs5nvpuewCuDm09dUgY6pfJNwiL1NOlmrLAIGstC+1T7VbfTQrbcyzdZJ/MEGrs
lhahEDqU0F0LNXWLWbw32KEXhLV/XRVHZ7iewUmoIKA2tzFPjbvfrQsDxQZV+xH3LPItxYR6
t9voSk0vBcBUK0+LeCOTiJPvAEc09GStokkY+np1icJSletl+WZZIcd312EHB6LmtK/fLaho
ZDs7boXeOlGkY2ABzS5K9Z4QO6G1ao6d66lmsoaGtfZ/LcNdxNDdqxZXV0TeXrGAOcQ1OhJf
i1X33nP3kM1qCWHOXTstXHu/LuAR0s6NtSFI6C3+++uXb3/8bP/yBAuGp/Z4eBrfFPz1DY3v
EMuhp5+XNeIvy9g7lCWunkstmfzOo1WjLosbVIgmhO1au8oKmmg/3Dta93koYFgGleex8xjr
ZnT5O00sgw169HrUvbx++l0bmeeS6l6/fP6sTDJDbDDaHzVffTJgVDVXSDVMF1nd6e1lRLME
FlSwZDDh8p6MwqPmbEBYBHuBvLsbU6/3aZoVJymDmbFXC10U3Zfvb2gp8sfT21B+S4uqnt9+
+/L1Dc05vXz77cvnp5+xmN8+vn5+fvtlNSfOxdmyiuMryMepGlzYPip62EirZyUaiieJ5rY0
laP+llZNc0edrA2L0/yAxoKkowFm23dYQ7C8EG9kpocu07Hjxz/++o4FJh6Y/Pj+/Pzpd0WB
tUnY6dyohbPsaKjQ04fbLsIHpEtKULBaMaEwi7qak0d8iALSwY5EjWcUTg88fnp9+2T9pMZq
eoOAWHUpk/lNKwievkzvj6X+iMS86lL8WLpKtEA0+3Tq99sLvUvBbRp+c7VgnUJJD9oohALY
4eB9SLhLIUn9YU/Jb6H6Zm5GuBuQNxoTIeb4LHId5SDvI+hN5/ZO46ozJxXprzHdDSWaH2yl
LLuXoad6bpggmP78PbmglBjqBCkBMKHKT68npD2FVkiIuRe5qt30Ccp5YTukv0yVIZuQ0BAi
HTeQe2txE6XjleoqHQKyfHqZp5Dcf0L6JxzdLZxeyju7C7fq5xAHsHYLqdwc3rsOdSI3f58V
JVt1YVFVkdf5pJ7BxOCwf9hbbF26aYkqrkTtQ8eyabknW9+W+Q5Re0kJ27KATPQFENoyhkwx
bEQWShiShqPmnMfQncN5smjy7WELK3BP9z1EqPtCZeQgWryQE0WD8h0x2Am5YWTaW8ZhgdRI
m4tpr7ySWGptN9Tmulyx95Nmx9WxiMgv9BPHpjtsGTXBnrriFZPR+k0KVhcuQh/ONjGHLS1Z
9ijvs6uycVRTam6d+2hrnG5v/mCrafSw/vENdgx/Pkqn7ai2WiSE9popEzy6ufih16eszNWr
R5XwcE4KaUtREiVwQlPdTYyduuuUofBxYLICnZ2sATLLxR6Y/BYg/uaI0J3soGPkGFzuws5g
/USmuNvFiRRSy3Mm8NJ3qOwe3u9Ci8xW23gRaWxuImCDJQbs4TBhLf9wr96XzdR6X779CzZE
WttdpWE8593Me9rB/2i/UMsoICxnkOXf+e6eUoufiyFwLXLAEodzpGoEH3zLPcjbsS7iNCfv
NuOSDUt01U7rLF2v0gd7ZyVbW5cBYT+8t12qBGWj5Q9xNFolsvIIovLtCStg88WgCR0BkWjX
nt1yZEu7DPHcU6Hlwh5aDjLVvNX4qnBoFX3cYOLXJSGMYWQYui+PpbS1XgCliK4iPbQ+S9rr
H5lLLfr65fnbm1RqjN+rqO9uvf6BkpG7E5Afzun01ld614vRpJrRYH4VcjKVQ0R9WV+S0QLQ
Fm3VDnTCZNTbYDN0IGUJM1y/admaS+d8Gy3YLRWChseHK+1RkMW7XRBaq0PUUS61kBLLO8rz
Xr8S72z/ZDC7AlTyvWnDWmEBoBmtQc/iwTKqAH+1NHFbiyryVPFwadCXCedMNjfYjHaZ627G
fpJ20WNB9IcCehGtUSRTqFMNCRcXItq3l59n9bwDfkIbx7ElqfKWundCRozGxweGEhOUw1k9
Zrik5FkyDh2TgYElhkFXTAkuJFBI1ZmKJavRKTOAShghRQUOPt6iEia5Ro/Sn15ffrz89vaU
/f39+fVfl6fPfz3/eKMeUD+iTkk6tsn9oF57Q+tNTPYIOnbUrD7NGDW4y3FCj+ij4kTC2RVW
oVVRR6dVnqOvL5/+eOIvf71+Iu1ICdUXtM7YN3nn7w5kpyYjmYqgZHlxqKWzEujlHT4O78vs
vJ4TFOoYtle9COSQ2/N09z1N/8fnb+jV5kmAT83Hz8/igPKJryvvEVX9jhgRxbnTcEr1/OfL
2/P315dP5FScoF7E/1P2LMuJI8vuz1c4ZnVuxMwZSQgBi1kISYDGEpJVAmNvCBozbWJs8AUc
p3u+/mZWSaIeWXTfTbfJTNW7srKy8gHbnw6zR3wsCv14P38lRO4SjkhJ7sGf6znTIfzkmqp2
LToGATpW2l9t+5R2dEcORpN5TKurvvL4eXh53J92pnDQ0fK6uw9gPP7Nvp8vu/e74nAXve4/
/gf1lNv9XzAPsaqVD9/fjl8BjOEX5CFuUwAQaBHw63TcvGyP77YPSTwnmK/K36/hHR6Op/TB
VsiPSIVy/D/5ylaAgePI5MBXYLa/7AR2/Ll/Q216N0jUo3JaJytu5wuAuiqyTHfxaer8+dJ5
8Q+fmzcYJ+tAkvjrAgApp7v9rvZv+8M3W0EUttNq/9SSuQ5GiUlClpMqeSBZYLKqI/JkhKOr
kJWkqRzmC36sRYQoCraOlACKEkKTCi0kQogm2iSRoalBMUeDCa0J95N0wqlUcPM2kcRku8Wf
E0Z+Y5DyWtm65M8zgsSTSUDqNOPgNYjmA0vnrq1Mlsm84+Hhdrt7252O77uLttRDkA7dwCNv
jy1OUq6H8SoTil8VoLqbtUDFzWych57qLgUQn1RYj+EW2Hf4g08mF3CF6kVLGM0caJynznAo
cLRkHXqkVjYOe1rOgzysYoeMLssxcq4qBMgqUj55ddPCHlzGmAWHiq5beHzTbfFdy+5XLKZU
Cver6E/M5yHnLo56nqzTzfNw4Pf7BkAd4BaozDICg0Ata+irihcAjfqWlAwCR+Yu5vmd5Uat
osCTW8misKdl+GD1/ZBOn4qYcajmydF2hNglhw2cgDydVJNCbXs8ADdUE6CHsfAQhS2a1cqN
M4wHzsitaP0PIF2LSyCiRlTDAeEFgbyvBt7I1ar0RrQWnKMoJS0g/IFaauAYv9fpJIwSHtkb
jr/MgtY2G+AGAa0i46jhmuYzA+WWib/lHBX8d0+rZzikQ2wDamQx7kGUT+0TRKimIMD6uMok
jKm4OlyfhDhpx4cjZEHTUoEm82WSFWUbW7FQfEKGfk9RiM5WdKjMdB56q5VaXVZHni/npOcA
zawHQWRaI4FRdNt5uHIdMugEYlwla6iADPXPPUv4aMT1SK0reo4FSt7zqOx58vMvAnz5qRAB
I/mTebgYKFZI4ilMnwkusC8BZCg5OIaVGOTb/ILDlxY4gFWN9hyf2oaWRcNiRGCkYt2YitU5
LBGlkpqX7ii5kFqYmu2zhfrM8ajVI/Cu5/aG5meuM2Qumeep/WzIHDklbgMOXBZ4gVEelEU6
6QnkYKQ6iwvosOdTD2cNMpAjrjR1cAM2ou6emzj0myES5L1ef6VPjUxRZ5HfJ4PaLCeB6zTz
oytFV0aJ7QFz6zCRjxue0hBuEnK+QjzyqwQOuUyxZze/aO51H28gvGun1LAXKDM0yyNfj7Lf
3fy6AoRsuPnYbKHNh+3Oehoqp5dukdiqL35Yjijodfe+h2tfo42Xe1FnsJXLWeOYoHBojkqe
iwZHTus4TwJSuIsiNpS5SBo+dM4DnYgR9xzuUkBtZvTSqjASKJuWPVUOKRkZF2r5PBwp3gxG
t8WrxP6lfZWAVdDEqFRCgJIE8srJWTMmrJHihFUOELMoT6VRvjpW6DihXGBlW1PXDFkmZWVX
j2CqutDaEcwWY7nnZsGarKs2n8YpsqiGa+ZSTYd7vNuI/UNLdX0nkN4S4XcvcNTfQ2WeAeJ7
9ImHKN8mBgGKlkH6/ZGHtomy22YD1ertj3rUBRAxjtqHwPMr/W7WVyx9xG+TZhToLvQAHfQp
9s4RQ500oEW9vpY7hUOsYzUYOJaeDgxBuEfaegAjHCo5rMoCo7vLohvzfTn8AkhHrnKvQXEp
kC0I8sDrKb/DVd/Vxan+kDyPQYDxB7I1DAJGnnrGQvucodfYaSvgfl+W+gRsoF1UG2hAXobE
YSYGQMpScmOPdNzj5fP9vQ3OrbEC4cBuhDfWcUIrQb9wGbRCz0IeLEZrmhwOu//93B223+/Y
98PldXfe/4NW13HMmpzXkmKeq6o3l+Pp93iPObK/fOK7mXqujQwvAUUtbylCWHy8bs673zIg
273cZcfjx92/oQmY4rtt4llqolrtxNcs/GXMwJXn7f9bzTW5w82RUvjm1++n43l7/NhBW64H
x/WexNzAIc9YgXN7GtcUQOpa0uibAu2DVcW8EV0BoPy+plOaupaoFpNVyDy4yJChUvNy0XNk
W4gGQB5B06eqsGhpOMquxOFoWYfToutpz3Mcak+a4y/khN3m7fIqHeYt9HS5qzaX3V1+POwv
qjQ1SXzfkZRBAuArjKzn6Hc9hChxLshKJKTcLtGqz/f9y/7yXVpBbQtyr+eqyaVmtSXP0wzv
Kw7tvAQ4jzYsmdXM8ySWKX6r09rANGXGrF6QHJylA6Gcuop8ANGTm7XDoXddcFPgHBf0Dnnf
bc6fp937DgT6TxhKRSLB3eA7xPbxLSu8wZKpwhqcrGcZ56kbGL/1Y7+B2iI2TVYFG2IwOVv4
p47AVsJ9vgroGU/ny3Ua5T6wBHv5ChEd1wdJYD8HfD+rD98KiuQMMgUlc2YsD2K2ssFJBtLi
2hXXHmv2ZSEXgFOpeh7I0Ov7hHDF4clMzI0X/xmvmSY4hPECtUCWxZX16B0GCIzVJbGVMmaj
nrZwETayrVs26Hl0mpiZq8SZwt+qGB7l8CkZFhQxspQGv3ty+C34HchKZvwd9JUBmZZeWDqk
gkSgoN+Oo4Zab68uLINTy6UVEioRGbGLo1w1WdufLHQ9Uqqrysrpy2yuraHzDpXUglWffO7J
ljC/vhpGAtg/nBDkI02Dkl495kXYWDN33xdlDQuBqq2ErnAXWLnRqesqAbThty9r/ev7Xk+J
5VSvF8uUeX0CpAU57MDKHq4j1vNdXwPID1ztQNYwH8LzoqVEwFAZWgQNSP8NwPh9OfDagvXd
oSfZYC2jeeYrcSwFRNURL5M8Cxxav8BRasTsZRa4pGz2DBMDw68IkyqnEIY7m6+H3UU8khA8
5F6NXcZ/9+XfzkjR1TbvdHk4nZNA8+i5omynByCBi1n8/Ht9zzdf4Xh5tHzWtuIWmhDf2kUy
y6P+ULbb1xBGVDoNbQlL11BVeU+RzVS4rewGaxu/pzAPZyH8x/p6IIbWJItaBGJ5fL5d9h9v
u2/aHYYroSy5P5RvGmFo+7Y/GItMOhUJPCdoXUzvfrs7XzaHF7i5HnbqzRRtWqtqUdb0Yzz3
fJNQXaV00c2JegABmPsebA5fP9/g74/jeY+XP6r5P0OuXLg+jhc49/fkY33fI9lLzGCby6+8
4arvq+8EHESekwIjOZWgRsLR3ncA5PYs7zuA69/AubTYUJeZfrGwjAA5OjArF9VoJy9HrqPn
T7SULL4WV/XT7ozCFsHfxqUTOPlUZUmlZi5wvblkM2DAVHSpuGTKsTUr1eiSaVTiIJFMrMxc
9YIkIBZhtUHqIVHKDHgkdSvIWT9QZUABsRUvkHrxAO1RT4cN1+Sx6gxeyqGkdCww6jnd99Uh
m5WeE1BNfC5DkPokBWcDUGtqgZoAbqyFqwh92B++EkuE9UbNCS2fogpxs8qO3/bveBFERvCy
P4tXEaNALvap8SXSOKy4Sdp6Kescx66n7vBSs3BtRcNJPBj4SqjoaqIETl2NVKFqBQ1wVHKF
GaBg0tOuCZ3A0e9lzjVmfjeuN3vf2H+ej28YW+GH9hceGymaeY+5mu7kB2WJw2P3/oH6O3Xr
K6/nI4tHJ3DMFFOLJ1VeRMWCjuyUZ6uRE8iypYDIV5I6h9tFoP2WOHEN55O8FvhvT7G8RwWN
O+wHJNuj+tgJ4I+S3Sr8ML3AEWh3W0CsyOBWR3S4MKRAL5NJTYUWQSyPCNNTm8Ejn6iWDLx1
+EhuWFmj6fz2df9BBBerHtC6WrmDQlNSkq2FMZpIK1b2ReXeY/g95X6u19ZVVmJ6QM0eHaPc
QZVpWUS23BbA6JLaYmQq2Mbs6Y59fjlzc81r59oEfYC+tlgCrvMUhNRYoK9nV5Sv74t5iBHO
PCSjZgU+bly5jO9lHAuzJR3oAqlw1tN8NcwfsC5LNXm6SjK6pYguV+HaG87z9YyRk6bQYI/0
AoooyQp8E6xiPVVzy5aU0e0KxiibkRr4P65LOqxfHlHdq8LOrD08vJyO+xeJf83jqkiVPdyA
1uN0DgsRVozNpEAU1YkVoaR1aiM+yD/NLd2A0XqFxSHdJUFTwT/Gcpw93l1Omy0/3cx0z4zc
58KrjMcUlrRuArae1pRTXYfO2YL8rKzpy0xHQLCtViFrdqGtFnPjSeeK8JsocT7aB2Ubirte
XPE8yV4+rTpCpotMHUWXsc+iXW3p0ijxbyhhW7I8jGarwkiNpxKOqzSeWpKCIz6ekFnG1YyU
8JNHjYuT5XpexJbigCgPWU0ExjEpWiMBEyOiC1prYFqgYhU5TtCgm+L6GJsOzu7VVVkqXU6J
cHsLtB+aDkaeYvXZgJnrk1EvEK2muEZInqv+IVTF8vtCQeYOydJcnDkSQNinRXUlmWzySzD8
PU8iJc4kyC6IoRlbwWpyAwnPFMlRAFCTPYbH4WxUEaKaxLoJzARakjLSbh1xBUthFCOpzckK
nZBki/oWsh6jw9W6KBXOhm6BmMPr3ubnNUEvtah6Km1ZqxnmClZCC3UgPY7mFTFepLCK5mgS
PA/rRaX5Ad/wC00Fjofuohscml83qIdFUUusiudGFsD1Y1jN07lyZxUIW7ggga2rRGJwD5O8
Xi9dHSBJrvyrqFZiqYeLupgwH0aH1vJztIZt+7rAwOTSZEcL2QymcU9UzzLMIp6FT1qBjQHb
9lV2nponuG6ujm3dNEbALxMDIOWT7izZeIFCJjvvPl+Od3/BmieWPLqo0X3kGJBJs7hKJP3n
fVLN5Z63Z3a3R/E/Pm7KjcpsRMdfUiYcmTGGVJJLZRUVusley2o3Ft8VdKOjKszl5pSsVo5C
8bsLaHaP7m8Yc4794Tqe75hkGbIDYFGaUqAhyJ6LW0j/JnIW2dFD35OR1+kS6GdWxx2emjtB
dqMEvWvtkNAystnbn6P3b9LfGpGWnmi6PDY/LtYo8Je3f/zX7S9GsZGIxXarQ+gtaa+pkoOH
z+W4B/DjWv3+fBwO+6Pf3F9kNCbjKMNpsvblvDYKRmS8ucq9Co58RFdIhvLDpIbxrJi+FWNv
zNDybqoR0SpYjYh2FtGIaLWHRkQ7s2hEPx5F2cFFw4wsmFEvsI7VyBIdVSvgJ4aB9hVRm6hG
e0NcygpcjWv64Vf52vVIOy+dxlVHgcdfUEFtnS4N9mhwjwZbe2SbyhZvzEmLoB11ZArbQHcd
s7RV1q4pcG2X3RfpcF3p7ePQhbVxcJdaV0VOZupo8VGC8a3VygQcBOtFVRCYqghrEXFexzxV
aZZRpU3DhIaD0Hav9woRcFvMwjn1FNFRzBdpbZbI+6vFw29xIN3e00FwkGJRTyRXjcU8xSVs
AOCqWOVwKXjmWSm6mCfSVaVYPz7Igo5ytRBm6bvt5wl1yUYIF8yjIwtWTxi7+GGRYJiKRtC7
nkBJxVKQj0BwBkIQoKfUud/cGJK4LftqtZTArWAGt5BEZImhZV6WRAtxgcgTxvV9dZVG9CHf
0t5EkkLaLFwm8E8VJ3NoKV4ooqJ8WocZ3IdUVyOD6AYKLiBZhqFy5W6bVMimWEnuEp58JOKk
OUz+LMnKRPF7ItAYQXb2xy+/n7/sD79/nnen9+PL7rfX3dvH7tQd8K24eR1e2aA7YzkIJcft
3y/H/x5+/b553/z6dty8fOwPv543f+2ggfuXXzEg6ldcRr+IVXW/Ox12b3evm9PLjj/fXFfX
v67h9O/2hz1aaO3/2TT2wt1tLq2xQ3AxnRdz1XEbUbDY+XRYQv9qpBPY2BKloimg29Gi7d3o
nC/07XMV9WGlF60qJDp9/7gc77bH0+7ueLoTE3DtryCGPk1D+Z1OAXsmPAljEmiSsvsoLWfy
ctEQ5iczJf6OBDRJKzmDzRVGEkqSs9Zwa0tCW+Pvy9KkBqBZAorZJilw53BKlNvArR+s45SF
4yzhAV+YQTVfZBkJNAvk/xGTuKhnwCwV7ZLAkEG4ys8vb/vtb3/vvt9t+UL7etp8vH431lfF
QqOq2JzkJIoIWDwjmgNgRoUv69BVzELiO5bTImM7LItqmXj9vhppVbwAfF5e0ehgu7nsXu6S
A+8wWn/8d395vQvP5+N2z1Hx5rIxRiCKcqI104hStbefzOCwCz2nLLInNbxot+OmKQabNPdW
8pAuyUGbhcCblkbfxtwTAln02Wz52JyUaDI2YXVFVBlZ3ES6FtFvjg06q+g03Q26mNz8uoSm
38KvalpVInZz8vRYheaOns/s84HBs+oFNdEY8dwc9hlG4LeMuhLkr2WCFHBFTdBSULYmN7vz
xayhinoeMbUIJnqwWs1siWIainEW3ifezRkRJDdGHWqvXUfk0DY2i94AbbZt05LHPlFaHlMX
oRaZwk7hr5rmAFV57Kq+Le2um4Wk/XKH9fqBuVVnYd8ljs1Z2CO5F+Ub1yJR+TsuzBPxsRRV
CIFg//GqvId0zIQRFQJ0bXmk66a0eLTHXWtmNcwTuBLd4NdRiMK95tIv4foUawE45X/Uni9k
hyb8/x8zXYKnVqUIxaNPiW/A6scCh8QGv3ZUzMjx/QMNlhRBtOsEV0caJWXPhQEb+uY6yp7N
1nGFogFF1WnbompzeDm+380/37/sTq2DHNU8zEmxjkpKDIur8bSNNUhgSFYmMJT4xzHihDER
BvDPFLNXJGiOIV+NJFESRPSJLiO/7b+cNiCTn46fl/2B4MnolUFvE+6v8SPehkRiebU2HpaS
BNHNcxGpSFHFpBP7wIS3/BKEs/Q5+cO9RXK7vS3ZD1usCTS3290xTL2o2SPxYcie8jzBWzm/
0tdPpfzQf0WWi3HW0LDFWCVb9Z3ROkqqOp2kET4CiLfOK0F5H7EhPtMtEYtlUBSDNkipBYuS
9Fok3pWehqd4Gy8T8QCKr5K8Ddob53UoZglcUVEVg1+uk/uFIVxE6IT0FxdXzzzR0Xn/9SBs
yLavu+3fcKuUwhLyN6Z1XS1YoyWpUnlTm3iGIVhVbLKqq1AeQON7g2LN157vjIKOMoE/4rB6
+mFjYMNh/h9W/wQF3/P4lxI4tiGrkmUhxpqTkM/lPzOabe3jdI7t58+5kz86By4bd8nSeRJW
a/6opz5JhcYzeFcDnPUYDFYa4tZuDMSAeYRqn6rI24RSBEmWzI10U1FRxSlppFWleQI3yXys
BKAVKrMwM2soeSLKXJafW5QGBokPLkfAsBWQq238aC3EQpJlQJn1Yq0WoHiM4U9ZSSkXjBjg
CMn4iTL7UAh84tOwegwtqbkEBUwVXW6gnMyR+kt5RAJuKIR1uiDp/ieEdPlbWFVxkUvdJ8rQ
HlUlaJyY8GdkznB8qnLJszhqNCj9DoxQqmT6Ydj2IozUZPvkN2ANTNGvnhGs/16v5OgaDYyb
FJYmbapHWhfgsKJu91dkPYMNRXzH4Nyg5rpBj6M/iY8sc9vuOkKJDLeFeM2KrFATZ0hQ1JsP
LSio04aCr9zA/pmMCxkrohTYyDKBEalCRZHNkFfI1pAIUiPi8/h9URbyd+oZl/mkwqtoxr/h
MeGRdlJUREhOxIRovnortvsauNZ6DF0DybWicviwaSZG2WR5MO5wk1Q2fPa8rkPZ9bd6QDlK
YqV5mSrOwfBjEku9K3g69ikcWHJ41kkxrwkLGYCqZlZINvxGsbwGJc8SBwXfVA8TDhx8c+n3
Y44t4VzL9GpUkhDOnPltkjydp2v/G3XVaxvmGA1znW8Wp91mhObYRVuRgHa9b55nFAvXCjf4
Znl2blpDDSp/UoiTUs51KJ4ZuGQC5y4Gj3Uk0aRGiYbk2pKPiiZSqC8grYjHoR+n/eHyt/Db
eN+d5XcRyeYJBJZ7nrmRlgEQG2EcSfkeJsxD1lkxzUAkyTo1+8BK8bBIk/oPv1vojbRslOBL
G/BpHsIWurVFZQprvK+nfFyg/J9UFZArUdmsI9Rd0vdvu98u+/dG4jtz0q2An6jxFE3Bmya1
ziqon5v5cROrf0nzXgJbRKNv2earSsKYa/4BJTHEBF0egE/OYTHJzENUDbI0l2rzlOVhHUnX
ah3DG7Iu5mp6IVEKMM0I7iWLufgkzPDG0fMog3nOcR9D2Aaie2XBbValfihwua5lDnIwmtSq
KV7Itjwm4T0Pu4wJbUhp/Wdn619yaPxm58S7L59fv+KjW3o4X07/V9mR5LYNA78S5NRDEbRF
G6CHHGSJshlbUiKKlpGLYSRGEBRJjNgu+vzOooWr0N4MbqaGs8+Qc361C5UUyVxSYUfzmonR
OAT8RIkHdgOMKDSKr5WEV+iunCgMemPR9ctL+1zNTL6+hWRPu2UscKGmKHBEAwpMFp6CcL8S
xj8DR6xnys4roAasTxqqnJ6mJIB5zAzfvje2PtWKqBjpUguZN/4OMrnePog6fJuFh+gSyChd
4LHEvgyrjKzcfxSlLtw2IoOC9Q2vcsIkJtknh3mjwqNcTP68sSrAj4uNqEipRWBT4yuGpg7H
a2Bvr5A4hzx0dUg6nbWI/1K1ZTDrmzqBnFXlpivzP1WzWxGLAamVnlH2QMhp1nEwkpG6Kwcz
zkwXqFNSpygzdodEF1kXLmjWBUVI7KzhoaueBRrv5mDbzD3C4+fxKeJv6qlrYX4ApjjnQFMe
fw53dkSzTBDPRteb3dtWNToHgExhlGzkAz49mw1ZrXaawYg77vkAMdllazhkhOMvqvfD8fMF
Pkt2PjD/XOzeno8m/pXAs0AmVJzFH2rGywPacC9yJ+oYlTbqAmHKv74LPLCsqrzxO4evwKJA
+Lh1YQ6k/wi5TaKDu11+McGDf7ZdaIBxk6gQdrX3IOtAeGaVlWQ+DTzOfQKZ9HRGQWRS9Zjb
Eeh2Dw4huBTCvS3MviaM5o7M59Px8PKGEV7Y0Ov5tP+zhx/70+PV1ZVZvxxvY9Dac9I8BxvC
zIlfT1/OoDWQoqO0WIM+rxuxER4l9SV4PAobhjsQaFvuAz5StZhuNCHV6laJIs5maN+O8YZt
oLF7DejRUTdff7jNFFtXXe+128u8CqQkqC885OfUELIKeNx3749knWoweUGPFrpf7Zv/Qbx5
BxBsigLIAHUmwYE4gEbxUM/MBsQW6BDvyTilh8YzCXjbVJpb08JGzX/grr1rYGQOiyaIEkDN
bZCqC4cN6oASIgNBwk6yCfRZshiL8MlfLO2fdqfdBYr5R3QLmwUBGajShkYniX2Ps00VEWuH
OulikQT9OsTrUPiCVpQ0CVpD+HaKtFPQJjdv7z2tAU5lA0rpWOcp1SGVxEGL0Q+Z6i09hB1z
VOGAqcm1yP9hge6sjSZxr/x7QPbm7W8Frs5WRk32xbgaU2Zq8yhsjLDLnCaENZ8EH0iNaEWU
WopuqtDV3ffD/u3j5fhowd60+5v98YSEgxInff+9/9g9702jdKnLoEe6xyU0jasaFJpbNhHN
L6pyOIap8SE7l2yh4HJ5IldqlYQzRrCTtUviy5Ex1tpDMmtwG7BcjqzJsEWd6b5xRbOKIu3z
j+NzR1aDEbzG8pCwwgZqWlqtOywyncg1GGQYXkG8RlRyC/StllnwRjbFESm6pRzMo55CllRn
Mgg5GoHT4r1gT12HnvSfDR+KPN6n1RmmoUSJ1PQFu1PJJwCK2HZqhd6XGkg6p20vxCbTxZ0H
js6hxtnJIYbZj1KpmTPAwVpobqqNtyZH+GJrgWC2Il3UqLXMnKaN4/imRt8qoOYaFYOG/Aru
ZqLpWdQrs1D2TS5LfK6gGR3bzv/lsi5AXgr3KzLBpUgdlBNFmgBY4tCliKZ0zwzmda32epQ/
TYnpQVVhkuN5mdTsDv0Lp4L6WiGNAQA=

--cNdxnHkX5QqsyA0e--
