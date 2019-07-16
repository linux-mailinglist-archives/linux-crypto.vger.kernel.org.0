Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F06F6A5CE
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Jul 2019 11:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbfGPJsC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 16 Jul 2019 05:48:02 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:44537 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfGPJsC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 16 Jul 2019 05:48:02 -0400
Received: by mail-ed1-f41.google.com with SMTP id k8so18998611edr.11;
        Tue, 16 Jul 2019 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0wfVyGH0X6+9UHLK++wYtzi5ucbNIhbZ7zOfGWzratw=;
        b=bi3N5ZXj1FPte/06BKkeqSw9+RZe091YwqQGlvugSipO5mlC1wectyFCqjvk5GiDWj
         50dU8UakVQOLMnbU1AzNzWbQ7PYs5gAUMTbXyI3IMGYXweOi//O42A+SndNrq4yRZncD
         47cQVKxFnXBLRlaW+IaPYYohvR9LJHuqZH9mvDWzI/ekOCwludk0iAsZ5ndLP714NZRU
         uRlN+EbLulhjsn2RCdD47tECtZd9KBmIShsQFDOIb/b2xV8Mprqv+fPAOK3msdWK85yF
         z2Mud/zXdfNdojoq6gwVKIzkzPLDPr3xfeTGzieF5qRe7A2QZNM/2NrbNNATpbm9M+80
         Mqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0wfVyGH0X6+9UHLK++wYtzi5ucbNIhbZ7zOfGWzratw=;
        b=WdD5cbdMjry5gBBOmxGWnMSazsDlF/EYEa/5nHuTlXJ5kUnIeOQ8SqZdukVjtROa55
         QDXXdxb+C9sJtpQ1M5VwSIeTd4AWviG+T+CzyubFDwqAlLtdfLfBKuhElIuswOaIfRUX
         YTEZtnCyG1NOCFFlm/2uniLlxuYUshSUyuh7b+qbnF5SYXKLr6jwbVtK3h+FtOnl1ZKm
         3H2ze9wa75yKOfi/Rcd+7h3MMzYPqZu3e78kh2xcHwGiuB4Bkcf66AAt0SNXgBXn6E07
         SxVRWGDJgN0cq1/0Ay1w6LlFloQ1yt/BiNBNbqM4AaOa7q5xxu3ETMvONdSzRdgW41ZN
         /XkQ==
X-Gm-Message-State: APjAAAWX7W8366lw5WHxEEUU5HBc9ZbzMIwEem9vlumHaFboKEKZbhgb
        ykKdd/wwOzojbtZrApk3fwxIZg+paVpE2Gc8/c+VP7CL
X-Google-Smtp-Source: APXvYqyAwk0IAK4j0C2BPjFQrIvCPpSoKQl9ImnXQAsd/YoOtu7lNU9rL4MDjSjZcQpG9rXLsZ5MgabuQQdlt8BKeLo=
X-Received: by 2002:a50:f410:: with SMTP id r16mr28400816edm.120.1563270480118;
 Tue, 16 Jul 2019 02:48:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:b3b9:0:0:0:0:0 with HTTP; Tue, 16 Jul 2019 02:47:59
 -0700 (PDT)
From:   Jari Ruusu <jari.ruusu@gmail.com>
Date:   Tue, 16 Jul 2019 12:47:59 +0300
Message-ID: <CACMCwJKJd8QzduZ3WKTqsHdftEaJH07iupKiWgSw7M0Xm7=gSA@mail.gmail.com>
Subject: Announce loop-AES-v3.7o file/swap crypto package
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

loop-AES changes since previous release:
- Set loop device queue ->nr_requests to better value than the default. This
  may improve performance in some cases.
- Worked around kernel interface changes on 5.1 kernels (multi page bio vecs
  + busted bio segment limits) and 5.2 kernels.


bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7o.tar.bz2
    md5sum e43d6a1067c59ab38ff6fe5c372177fd

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7o.tar.bz2.sign

-- 
Jari Ruusu  4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD  ACDF F073 3C80 8132 F189
