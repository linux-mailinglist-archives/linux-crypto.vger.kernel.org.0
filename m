Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84E94195EE
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Sep 2021 16:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhI0OI2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 Sep 2021 10:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhI0OIS (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 Sep 2021 10:08:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C980AC061575
        for <linux-crypto@vger.kernel.org>; Mon, 27 Sep 2021 07:06:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t8so52304993wri.1
        for <linux-crypto@vger.kernel.org>; Mon, 27 Sep 2021 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZzRG5L5X/1EtNsXhsnaD0Nv7OjOgsEZ9r8dkd6VSUwM=;
        b=X/rSRqDXxxtRKNtma75g0UuhSfKDW6Ee71c521/a1ztTJ4CAfOZgAt9XnuliPIpbT+
         sVgPUmUiCYnOzKaIndtDrYVNmmzPC5hKd22zDwnqiTH3y7Y6sHdTPeQOvJ0onoVgccpN
         rq+0DygGxhE7MzcfFjeUfTKox6p70wFcWU5ELV+47hYby48V27uyARtYDSqUj76GSfZ1
         mIakqrq4Q3WC/7ZeUk8ukcKVMPJTHm2jLViEG2irCyhqIu2ThzHhuRZ9xiRNzrePy2Gw
         kIibjECHgwZN9pwyOG5RrwMCrpHYvXNDyOvPQw3AGnJFGvRQOIqo96ZnE7IXuCRUL+5G
         2fOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ZzRG5L5X/1EtNsXhsnaD0Nv7OjOgsEZ9r8dkd6VSUwM=;
        b=Fux1Fx8c6TRneg26viD83JusY4l7tQE6xnj6H5AIityhbAM0z4BTHxzYh4KGIO2cv/
         nVvCUjTouQGO3UxFfjM0RCr1fOO9U0r2XKusLFMruWICZCHLm+lnxJoWWTPWEcvtqNnN
         y+uEGOnWK3ZydB3M23Rlhn1sZYndmktX54gYpYHLX+zoddSIBMOerSClWvv2zPuWdfOZ
         uHIhi4a3CIpw8rHy45EFom9W5dWJjS2mZxcJsKPV6d61Vw+vyW2t9zuCVEx9UbIO+sxa
         7KwsgF0Nh34EumkVSkMkr1PJKRxQ/VPa5tjMkN66dEq3tgldWq2uGHnVGbHFY6TWWyMR
         Zmgg==
X-Gm-Message-State: AOAM533/SfV9SnYPuOhuORSK9L4WVozS0xtHJ9r/tKIq8unRKcxV8Yuq
        23IGv9G6DRlSCaH7u0F1eLcFUt7BJpw8DFRnoSf+hFj4vmk=
X-Google-Smtp-Source: ABdhPJzShmoPJ+phijNBtnqTBlh6/EtA4JNMlzGOogRe4lyeGU3tt/w8AbAR7iK7JUxNk74VaTe/QlFBar3DQusEXx8=
X-Received: by 2002:a05:6000:1103:: with SMTP id z3mr5443wrw.312.1632751598447;
 Mon, 27 Sep 2021 07:06:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f501:0:0:0:0:0 with HTTP; Mon, 27 Sep 2021 07:06:37
 -0700 (PDT)
Reply-To: kofa19god73@gmail.com
From:   "Barr. Kofa " <davidmanknell@gmail.com>
Date:   Mon, 27 Sep 2021 15:06:37 +0100
Message-ID: <CAN+3QRbtMzs39kEfFO8VTzdRp_WsWMii+x=7fTO0-fWiEGdSTQ@mail.gmail.com>
Subject: Re;
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

SGVsbMOzLCDDnGR2w7Z6bGV0Lg0KDQrDlnLDtm3Dtm1yZSBzem9sZ8OhbCwgaG9neSB0YWzDoWxr
b3p0dW5rLCBrZWR2ZXMsIGvDqXJlbSwgZmVsdmVzemVtIHZlbGVkIGENCmthcGNzb2xhdG90IGVn
eSBmb250b3Mgw6lzIGpvZ2kgcsOpc3psZXQgbWlhdHQuIEFtaXQga2V6ZWxuZW0ga2VsbCwgw6lz
DQptZWcga2VsbCBvc3p0YW5vbSBtZWfDqXJ0w6lzw6l2ZWwgLyBlZ3nDvHR0bcWxa8O2ZMOpc8Op
dmVsLg0KDQpWw6Fyb20sIGhvZ3kgZXJyxZFsIGEga8O2emVsasO2dsWRYmVuIHLDqXN6bGV0ZXNl
YmJlbiBtZWd2aXRhc3NhbSDDlm5uZWwuDQpQb3ppdMOtdiB2w6FsYXN6YSB0b3bDoWJiaSBpbmZv
cm3DoWNpw7PDqXJ0IG9rw6kuDQo=
