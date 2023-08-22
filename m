Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD1784E9F
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Aug 2023 04:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjHWCS2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Aug 2023 22:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjHWCS1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Aug 2023 22:18:27 -0400
X-Greylist: delayed 917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 19:18:25 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8917185
        for <linux-crypto@vger.kernel.org>; Tue, 22 Aug 2023 19:18:25 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-c7-64e553f378c9
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id B7.72.10987.3F355E46; Wed, 23 Aug 2023 05:33:55 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=UVCydWsfwbTJXCCdm+C9DWKtARRK342rDtYW/rR+DwzXmguYJcRkaFMlAIhqNtYBe
          1mwfWC+tKOQp62fYFO7s+ym1WrEeaEf9E9VsLkiZ4T6P6IFzuHL0zi0JvnOy3itI1
          vjcebOwWf67Wy0ReMrqnpBPoZzO5TA6YLATRvy6GM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=njPMSTpHFAbhDUqTBLa0Z7PIYdBhoCNZXmun5ajzsnlxRaq0er/4xJETrqy/VI1mY
          cP1FlIGz0ylLQD89HDHO0MfMCEs3EWnj/FUD9PZaANXGIjz9xDwD/PvPCxkE+hJRN
          SVM+bnPe9rHmEozDJlY0NSvzqx9vtpmVdOtFjbq8o=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:30:59 +0500
Message-ID: <B7.72.10987.3F355E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-crypto@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:13 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVyyUKGW/dz8NMUg2dzpC3u3/vJ5MDo8XmT
        XABjFJdNSmpOZllqkb5dAlfGknUXWAp2M1e09S9iaWB8zNTFyMEhIWAicW9BVRcjF4eQwB4m
        ie03bzCCOCwCq5kldhx7wg7hPGSWWH3tFzNEWTOjRM+eNWxdjJwcvALWErvPt7KA2MwCehI3
        pk6BigtKnJz5BCquLbFs4WtmkHXMAmoSX7tKQMLCAmISn6YtYwcJiwgoSMz7qgMSZhPQl1jx
        tZkRxGYRUJW4cn0t2BQhASmJjVfWs01g5J+FZNksJMtmIVk2C2HZAkaWVYwSxZW5icBASzbR
        S87PLU4sKdbLSy3RK8jexAgMwtM1mnI7GJdeSjzEKMDBqMTD+3PdkxQh1sQyoK5DjBIczEoi
        vNLfH6YI8aYkVlalFuXHF5XmpBYfYpTmYFES57UVepYsJJCeWJKanZpakFoEk2Xi4JRqYJyc
        EyVZ8u7b3DkHI9/yBh94tSNvuZXY5Jo9WTMClxZ4P+fR8XsXtH3CgUc/m2MbVvvnLNR8vyCm
        yZj/s2Xrrtxabfnb25VFe/5/bmDM3eq1YNNfLoHfed90a93qfhycyRwZwtQ9PWAPR1/bOvUA
        Q7c97GtfLdOfJJn292vCFd5dVUdcZOoSeJVYijMSDbWYi4oTAb9TIKg+AgAA
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [203.124.41.30 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

