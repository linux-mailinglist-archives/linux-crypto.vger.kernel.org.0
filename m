Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E597D9969
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Oct 2023 15:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345856AbjJ0NLp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Oct 2023 09:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345780AbjJ0NLp (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Oct 2023 09:11:45 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D79618A
        for <linux-crypto@vger.kernel.org>; Fri, 27 Oct 2023 06:11:42 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-584042e7f73so1099282eaf.2
        for <linux-crypto@vger.kernel.org>; Fri, 27 Oct 2023 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1698412301; x=1699017101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CbHs0hs5xBGIkGYrDsgL4t8wwSyYbOKrWiZpYVZshg=;
        b=DFNvM/gVp3dhKo0nJow7WQyKjpAcV+pUrKFN10JwSj8ckrfLY4v0fgGUOq8Nq6IXk/
         wMeKbO83XgusdJaS1vANLxCbP3XvE/LRhvN7M9B3aT+ATDJtVMb05RFKlVIZvhpialS9
         H4FhETazcot8KgoRjB3SO+9ouae7h+CEy0JN/2hirTDDZA3IdomT1D5aLOBp9eS2TDpX
         HvuhV+vr/C/CsUo0QvUIR85znjwSXO4CWLmJKdiXE0hiwhVB4kbfJIGwnsHRFUeDURn4
         IsT5+IoLZpEVwKP90g6leOg7atGN+NSsXHC26xbyo9iPTexssXITgAj+rrB8xRuuuF1L
         /zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698412301; x=1699017101;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CbHs0hs5xBGIkGYrDsgL4t8wwSyYbOKrWiZpYVZshg=;
        b=F+AVPOGIIEs0+W7hPFvQZi+WgciW1vv7lD5MFJBRtgHox0/mwJAcEaFyAMfaTVAP8N
         FraLlcw9VryA4JpLEnfRTalkqBe+5nDHKx2MGYox4iqCQ0gd1dqF6MkVt/+6arN/6b/A
         X+ATmZCkFL47j1drBBMNiyghpsNQiijNUbk4T3kwlzOEiBXV/IOPxy2CPFASwbLNladD
         Q1LpAygnvimQRbBFSP5BV5M8wjqn/74lkXjLUPuDl1sTbBIBFBRlL3XOaLBB/nAe2O9G
         NmAWg3E3cGW9rpSxCzM1MpKkyiu5L0Kjb/cI9A/Ri7DUkGStkXZdY1TWDcFRRlSU5GAt
         tgiw==
X-Gm-Message-State: AOJu0YwUsetU3bDZEY4Zz6166WdKYvksbqRAcMsJeqZ0Unk0uTgP4xlm
        Bp1OwMhaKa4+bLuN319UFr366Mns0T6qS+mWL84=
X-Google-Smtp-Source: AGHT+IGrU1DISmNmvzhJhqxq28NKsMnuhIs6OZ/9Hbl9MhdUGy3deik7JYIIpqMv2+w5lJeBpUhN0A==
X-Received: by 2002:a4a:e0c4:0:b0:57b:8ff1:f482 with SMTP id e4-20020a4ae0c4000000b0057b8ff1f482mr2487130oot.0.1698412301141;
        Fri, 27 Oct 2023 06:11:41 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id f19-20020a4a5813000000b00573f5173a57sm361011oob.23.2023.10.27.06.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:11:40 -0700 (PDT)
Date:   Fri, 27 Oct 2023 06:11:40 -0700 (PDT)
X-Google-Original-Date: Fri, 27 Oct 2023 06:11:35 PDT (-0700)
Subject:     Re: [PATCH] crypto: riscv/aes - Implement scalar Zkn version for RV32
In-Reply-To: <CAMj1kXF0e+MKyDJPS7r=LWusEBCaw=t03JC=+Dz0Qk+GmY+uXw@mail.gmail.com>
CC:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, christoph.muellner@vrull.eu,
        heiko.stuebner@vrull.eu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Message-ID: <mhng-ff1fe914-36e9-42e8-88ac-44c7f6976e3d@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, 31 Aug 2023 10:10:21 PDT (-0700), Ard Biesheuvel wrote:
> On Fri, 4 Aug 2023 at 10:31, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Fri, 4 Aug 2023 at 10:21, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> >
> ...
>
>> > Hi Ard:
>> >
>> > Any chance you could postpone this til after I've finished removing
>> > crypto_cipher?
>> >
>>
>> That's fine with me. Do you have an ETA on that? Need any help?
>>
>> I have implemented the scalar 64-bit counterpart as well in the mean time
>
> Is this still happening?

I don't really know much about the crypto stuff, but looks like there's 
still a "struct crypto_cipher" in my trees.  Am I still supposed to be 
waiting on something?

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

In case it's eaiser to take this via some other tree.
