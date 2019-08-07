Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE04846DD
	for <lists+linux-crypto@lfdr.de>; Wed,  7 Aug 2019 10:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfHGIJC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 7 Aug 2019 04:09:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36670 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfHGIJC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 7 Aug 2019 04:09:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so90455767wrs.3
        for <linux-crypto@vger.kernel.org>; Wed, 07 Aug 2019 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fG52fuDXQj1Bi6oU2rMeiQi7jmehOcFj549DOFtvvcA=;
        b=uI8uJ3cFRakpHP5sOZnNR63nmlglCor5vipRBkY7I91V9JYMXWdFCSiqKJZN822YzV
         HdwCpwKs2ez0RnrUhW1O8vkLAUNP6pe96NO4eLD9sREE948FdN4D8RFOfvrtuG6b8OC+
         9ykQ6vXX01glmYwZm2ifOuHNMP/sQr1Z3K8THBIjImDXr8fNlJ7QblsCR9vhVTbEHnAi
         2ydW9h/OW+vQYmICUvDy2ZIAhFOP0qxOx2XJ0qPc2c6P/bLEuog3IGw+pnkqPVkQ78GA
         /jqoE8FSJBbJD4Z09bC0gX6ZT4Tz7HozI0JnpLsLZT7nc2c8w1VghLA4zdj4bEBIUKpu
         VUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fG52fuDXQj1Bi6oU2rMeiQi7jmehOcFj549DOFtvvcA=;
        b=bM0eJ3AkMqPPqEEi83LTvwDTUcwU7WAgjP8paDKrE6ammojLm9WZS0+ZhiNdtBwwDl
         jDYjojVY1L1uUjAW/xkkancYcEq08FOMPTypfyjRcCb5CEesfD4ACyhUz6htmELTE3lr
         3RsUwvS3yzF+y1JkNPOG5R/5vPfFJDJfDgB3yIuvZuj7vbY7clyYu9AMnUi2V/ezZjXc
         tULR4RWjLjyA54JeUbnh4iUhJTbasUJAJoKET+L0aQb7h91GB+f4+Pqse3JyGdx/wmZn
         C3IGqvy9xGWqFmgEd0HPDgbBCOCawyiBCVOqqIsdxVFhg+/Y+z7L4RLXGRdY4kq1uyS0
         JExQ==
X-Gm-Message-State: APjAAAWngNuLlKulytnTNl4PFWsDOU+cuFTQYLDFM9Chw3L4Ue7u135H
        oEzfHkZFZ3/lUPczo8UdFWQ=
X-Google-Smtp-Source: APXvYqyv3Q+2JHo68IMU5YGZW4nZr/gEHF60B6klf9P96GJwa7Z8eCIlUSoK6v4OTKQKGumwnTvgbw==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr9492849wrp.188.1565165340088;
        Wed, 07 Aug 2019 01:09:00 -0700 (PDT)
Received: from [10.43.17.10] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z6sm2377162wmz.46.2019.08.07.01.08.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 01:08:59 -0700 (PDT)
Subject: Re: [RFC PATCH v2] md/dm-crypt - reuse eboiv skcipher for IV
 generation
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com
References: <20190807055022.15551-1-ard.biesheuvel@linaro.org>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <c83ec561-4359-3f38-3da3-65f9f18c1822@gmail.com>
Date:   Wed, 7 Aug 2019 10:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807055022.15551-1-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 07/08/2019 07:50, Ard Biesheuvel wrote:
> Instead of instantiating a separate cipher to perform the encryption
> needed to produce the IV, reuse the skcipher used for the block data
> and invoke it one additional time for each block to encrypt a zero
> vector and use the output as the IV.
> 
> For CBC mode, this is equivalent to using the bare block cipher, but
> without the risk of ending up with a non-time invariant implementation
> of AES when the skcipher itself is time variant (e.g., arm64 without
> Crypto Extensions has a NEON based time invariant implementation of
> cbc(aes) but no time invariant implementation of the core cipher other
> than aes-ti, which is not enabled by default)
> 
> This approach is a compromise between dm-crypt API flexibility and
> reducing dependence on parts of the crypto API that should not usually
> be exposed to other subsystems, such as the bare cipher API.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Yes, this is a good idea, I'll test it. Thanks!

Milan
