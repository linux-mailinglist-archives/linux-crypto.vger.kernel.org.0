Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DBD3CC172
	for <lists+linux-crypto@lfdr.de>; Sat, 17 Jul 2021 08:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhGQGLY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 17 Jul 2021 02:11:24 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:36757 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhGQGLX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 17 Jul 2021 02:11:23 -0400
Received: by mail-pj1-f44.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso10117028pjz.1
        for <linux-crypto@vger.kernel.org>; Fri, 16 Jul 2021 23:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7oIpjjlNp3WRf5oo4fvh6ZKEozEtaUWbPUQq7Ygs9vE=;
        b=AsBq3EY/ZjnxLIl3ufjiBSjPzJ2bEQZrdE76VXvFaPcs5b09OBtrNB2ue9S7tI0LgC
         1TWKtUdQ4DPGVer92m14AIOS508FEkBR0R2CmGLrn3Cc62kOa36i/Br0uh6WEhcAiHXk
         ka06gOTia2/6zP29mTglFCBQ+8zKfaGJOMkSAEl+2FQo9seaAgNDeVfKF+QpAWHuiExN
         Mwpt5i/woizhHlHEc+Z8PUzNykG9ORNpZWr4qVLnXNeuVsTWN3Osow9EqsnGTgS9SHVe
         vyiaRQLvWamSWrq550EWEutP4JZqSjxFPnENcVoQoBRIDf8MBGF2NK86puAR1wJz0pvb
         KRXw==
X-Gm-Message-State: AOAM530U0kYJpJWgYP82vYXQbaIfGrZKx2Ei+STEppSZ31hZUiEmC/Q5
        sCogyzr6vOdBAeN9fH6HgBw0GOrz+7Y=
X-Google-Smtp-Source: ABdhPJzeUQ1Gh2h8ZGgLLZuk5O1+ggANUfqHOqWfKdIw7Ppkw1lJYnlvw6iX53Ac4wrjIJcLDg8l7w==
X-Received: by 2002:a17:90a:28f:: with SMTP id w15mr13537190pja.70.1626502106462;
        Fri, 16 Jul 2021 23:08:26 -0700 (PDT)
Received: from [10.0.0.146] ([162.211.128.122])
        by smtp.gmail.com with ESMTPSA id i1sm12010601pfo.37.2021.07.16.23.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 23:08:25 -0700 (PDT)
Subject: Re: [PATCH 01/11] crypto: add crypto_has_shash()
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-2-hare@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b6723b88-07d8-228e-ea36-533608087672@grimberg.me>
Date:   Fri, 16 Jul 2021 23:08:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716110428.9727-2-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

> Add helper function to determine if a given synchronous hash is supported.

Can you add more info in the change log? Who is the consumer
and why is this needed.
