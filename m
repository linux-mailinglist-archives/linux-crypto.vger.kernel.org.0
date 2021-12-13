Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C8D472D58
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Dec 2021 14:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhLMNcs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 13 Dec 2021 08:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhLMNcs (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 13 Dec 2021 08:32:48 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29594C061574
        for <linux-crypto@vger.kernel.org>; Mon, 13 Dec 2021 05:32:48 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k4so11171415plx.8
        for <linux-crypto@vger.kernel.org>; Mon, 13 Dec 2021 05:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Av10FJHZ16PNlaWBwLeHhLYMKvHi/4lm87heoggNDKA=;
        b=JdnkCJlR77zK9fWaWQMT9yUuwptCa0e0cGCr43LmJEgC7n5gBm4QL5WjXshJ5YUstR
         v0JqtjYSR5G0XbBZ9J3nYjSfi80qBgern+Kn92jPM1fyFQPDkvc9BcSjZOMNV0QwgbMe
         zeyGnAaY24CqnXYn+1rWk4b4hnWRYDcCN1QY198FCmvtzihtJeMJu0qrWuATSceaY2VN
         LWySjHvhx/zuUEF4bvOhQet/zMKXHHTrr+UtRwMrTyLEE18T01ivAY+pHOYjTLqT+g0b
         3m+XjRs9zqBAu6T2KROg1UwiKn7IGK9/yzOBlbMQrqJE52d9k0rgarDbhLE2JqO7DL4P
         prqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Av10FJHZ16PNlaWBwLeHhLYMKvHi/4lm87heoggNDKA=;
        b=RlYO/+jAiFmC2ewGBKH8z6tgBY+PmqRkNUUoaIfBtKLr4rBJg0y6pPjQK7Uc/Bfto9
         UoOeyk+w6X0Ej8zJgxBDLq+IJTVzp0qsmeAOP8OC31ZJhpTmoOalkbmTgA4ic08FBwXQ
         ci1MaorWaSkMCAKZbylsIdpCeY59/f1dLj0saJ54uOzOxiI+dBA5s/EruWOedAw0MqWX
         Q4kJi8o9bnYZXYGyIeCzkJI7JEeI9MrRpvdIDIO9+UFD0QRbj9qWAYnMf1K8uGK0lpvC
         0vf62hdbIqHtNFkHNZ7xeqN8Pp7ZU+H65+aAXO+LkiL7vF07YFHUroRGBoip5QkAS6/5
         ZDYQ==
X-Gm-Message-State: AOAM530LoyJU+AqnQSm0e/QCzdaNAvJWMKRmQFYu/WNLF8ccf0xrf9Ut
        yFgdPXtIGkjEw1+GrxmqyhyP2l+/P9B1CEUfVO8=
X-Google-Smtp-Source: ABdhPJwNbuJ0U0U+YcX6w2CR5YhQ9kN3M6BumDEBm9Lzebb1afckdSGKApzceKNVGPZ79tHFZdGupMcgnfLqKyVWHLY=
X-Received: by 2002:a17:90b:17cc:: with SMTP id me12mr44385500pjb.141.1639402367658;
 Mon, 13 Dec 2021 05:32:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:680b:0:0:0:0 with HTTP; Mon, 13 Dec 2021 05:32:47
 -0800 (PST)
Reply-To: fionahill.usa@hotmail.com
From:   Fiona Hill <grace.desmond2021@gmail.com>
Date:   Mon, 13 Dec 2021 05:32:47 -0800
Message-ID: <CAOW9D1tetYhOhsXXiF2SZk-KzmtDUeq=T-Wp+gzWYuiuN9acLg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
Hi, did you receive my message  i send to you?
