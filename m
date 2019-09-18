Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4F6B5E3B
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Sep 2019 09:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfIRHoc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 18 Sep 2019 03:44:32 -0400
Received: from mout.web.de ([212.227.15.4]:60187 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbfIRHoc (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 18 Sep 2019 03:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568792649;
        bh=caFlKgqR6Wv8ag8+Edy0U8SPuU2/zu9u+4Af/rVsdRw=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=NFE7W9eWEbAMy8LL8+dsY0qApCZuqaTgX1tVY6r/iKo2e37EV4PXmxdSNLM5xW2jI
         8LXpQbz0fIK3xTC9KmJxaSmcWnrFCz1nOfL/pH+3eW3kGzPy1YEojModg52Goyn6JY
         9Q0F4qbSSEuD76M6Lk/yBLmAktIPKvbUoBMCFjnc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.2.101]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9ome-1iLSzp32To-00B4Os; Wed, 18
 Sep 2019 09:44:09 +0200
To:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] hwrng: mediatek: Use devm_platform_ioremap_resource() in
 mtk_rng_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e6e03822-c68f-55ea-3a65-ee2a44f50e8c@web.de>
Date:   Wed, 18 Sep 2019 09:44:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TVr6y4BRlKjPTWQx2XV0ctmQfukyEOFSyasBxHm0cPqp4kGnbCx
 3CTyjRCtl/6XgA40ZC7LZQ0Is9PIZuyInCqJxyMiWbGqx2QXFXanTkT54S76bZBjy5Th9V+
 /Ezib46AKGIJ8/WBIh63P0mCPgdLj1+YheoQgt8F4wrwiOJVRTsQe6s+UwxXUqwYcdsg7bo
 jgdIUcnh2iCJzwsOmnk4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rhlOwn4khUE=:Cs3LDjWNfGQIwK9jjg8Tb5
 0CByEG0g1DNdKHXAntaVmaokfVKhSfQzWKow4JQbsQGKVDT4WShzgmsaDPEH5Ft/++z9rS+ab
 ifdO2Rj2qm4TSquSfaVPaWIUrq7w4itO88Figd3MkLpu1yeTavHqp1902+SkAlOxJLtojeCZ3
 5x+PlANKBDDe+L3Y6ykjt1p3VolIoVczFxGNDUwu4DwYekdXJJ0GUj1IKZllihiBEc50wN1E5
 lZD6kgteK74dUNJeEJ8GKu+bS4PqmDu8ipdWYrcIXu7uh1A39RxxPbVhtG2oLB1YSstRGj5r5
 ubi33y7rko9XOzhlWyNBFc1ycU6Q0UpdRB6TP04lqI3TIpxKI+wYa/qjqI/AMTc6I4dNNHW/O
 Wh/QKYlaDB0IycRVRBwxQv9ZjQTgnMmEUm6v+d7NGP4NnynsHa2Eg2nCo1wkaZnfzHSj9Wj6F
 Z9/AOtEjdGRwl8mD5Yi5A7Fd8F3DgLgU6RDYDFdoPQlkdA55dm9+Zyi5yLWtiSrEfF8bbjG6q
 8AQVFJ90svuGjZd3X07GM+/H4JD5mZgXT/ZAL37h4wWs10Z/ZY+rbyVXJk9S1qD9/BqmmEXqC
 6fdSwxUYjcqaz2ewVyZ4vCcWh1Gsv73Me45kcKCgQd0gYuKwL5+A2XodN3x0OcqFXli9oJngi
 jwO4CkO5wXPbz/+Hy/PeEuJpSfVzJmCrcmZQeklk8zOHcO2JzJ5GFgMqwd3Paf1hCqRMTXJhm
 5789Imgo4WAQzboqg3r+BRocwrvbK2LMe2taMWcWdWo1mb3tjTb1t/fpXpShEo7XL7rJmbGuf
 NqqO/yba605V0ldFr+NQjkcYbMOreAAoETL5JVbF8tH2I3ClVexDfEE/9U3ZSTtlMTGBt+REI
 2/ZykXANYGmCOdhpxkktW6sLO/0bfh5DwlcsgRIdjUm4Kxa9DATBufqF7q8mqsXECynqzZmq7
 jnuMuyz5XgC5BD2XGrxrxLPPYsdXwOwvN5xVNsEJrpd7fLmh9GQQ5jRaN90KEPChkMOc12zPB
 Tan2S1OgeVXvIDt/6PejXFkli7GkDKpxSOolScaJwMzr6gT1Y5WndGodRAgkFzFHBW0xGykoJ
 rYdJTuSdKfqgBnQEegRa53Vnetn5Om9Hem+bRmFtFXX1oYP/2XDi/g7v5nKs81ASrHdumQ0rX
 b3hPJDixQLdgreMC2nbXiPZ86T9JnLCnWaTJ3g8rKNwSuekDNXKZdMOnRveHxyMyYB/AyHYXL
 SJZ6tr7r5q7MlteDllmsWB1ePDRG8FBF80hbi65kWbCQB3bxbMUpwoVSOjuA=
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2019 09:34:11 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/char/hw_random/mtk-rng.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/char/hw_random/mtk-rng.c b/drivers/char/hw_random/mtk=
-rng.c
index e649be5a5f13..8ad7b515a51b 100644
=2D-- a/drivers/char/hw_random/mtk-rng.c
+++ b/drivers/char/hw_random/mtk-rng.c
@@ -105,16 +105,9 @@ static int mtk_rng_read(struct hwrng *rng, void *buf,=
 size_t max, bool wait)

 static int mtk_rng_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	int ret;
 	struct mtk_rng *priv;

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "no iomem resource\n");
-		return -ENXIO;
-	}
-
 	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -135,7 +128,7 @@ static int mtk_rng_probe(struct platform_device *pdev)
 		return ret;
 	}

-	priv->base =3D devm_ioremap_resource(&pdev->dev, res);
+	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);

=2D-
2.23.0

