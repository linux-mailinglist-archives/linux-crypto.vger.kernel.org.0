Return-Path: <linux-crypto+bounces-5484-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9090A92AA4A
	for <lists+linux-crypto@lfdr.de>; Mon,  8 Jul 2024 22:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F3B1C210E2
	for <lists+linux-crypto@lfdr.de>; Mon,  8 Jul 2024 20:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D0522EE5;
	Mon,  8 Jul 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bE7c3Ouw"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00C208B0
	for <linux-crypto@vger.kernel.org>; Mon,  8 Jul 2024 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469165; cv=none; b=E4UdZ8IGuXlbVjQr7yJPQyPManGQoyBHQ2IPNe7cEWLyLQ3gqZMWB+nTZMvWrzzVFfcHxHb3hb8612ekHszIrX1JvVzplZnCD5fbmX6W5CG9wyTXQNU26HYZBpasbcaG78Qy6JhK9qiqfvMemcbKPUH0bJhF2R2F2GQPQpFn5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469165; c=relaxed/simple;
	bh=aRagdgTlsE3MWGFlwzI6ef72f+KQMUPg1M2pXIo5ZqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbrSTM8DIZ6KMNztTDH3YpRDJ7OSRfcDN7tgF+K08JPeL6r7gk72UyxrrlID79BpDU7Us3AsDMLj6VEvsA/9uGYh9sHDmXsCb9DM3k6MGa49lzfQt3I++BkV1CV3pXAW/XZPPs6iuBVIJCLFaINn0RvLMWZgiGBWJ5q3sHzizAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bE7c3Ouw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720469162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j2lTC/uV+6KmvXYNZup4rA4eKjMMz1SsHbPB0aVLD3U=;
	b=bE7c3OuwjhP+5SSY4w9lA9AF/MWu9vn+gZ60p3zN3xjHUikoo9oOgbcpmDq+6Bd/fgQ4Rt
	uxDSer4WVMpeLL8QR6Kn5f50+b08L6Aq7wee1QBkR9uK5OAzt45glSPa60jd0XPf0Jp1YY
	AAKTAGbSETbxkdF4klet6mLzXCuF5zA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-m5whSJCzMemBhuM1E6b88Q-1; Mon, 08 Jul 2024 16:06:01 -0400
X-MC-Unique: m5whSJCzMemBhuM1E6b88Q-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ee92048377so43282401fa.2
        for <linux-crypto@vger.kernel.org>; Mon, 08 Jul 2024 13:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720469159; x=1721073959;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j2lTC/uV+6KmvXYNZup4rA4eKjMMz1SsHbPB0aVLD3U=;
        b=JmG1gtnZBkzUJBJ545CeOYVLSN5ujOJcL9D5cmqtkGIPti3wcZ7VH6uGNp210F01E3
         Hud6ULUQjpdayXLZl7hAfhWNWLuGu1D+Z0M4KJo4hI55JYJGDNKV5vfHes5sfePN1djK
         uzk+yg0zkZaAAcTAIKtImSLRf/N7kteQzmQotGdpspZzGjDn5epzaEZn4uzaYyXmH0Pv
         ltnFc9CLagrfhzceqD3/W7MXTOJ6Eeftg1WE14iUZYaYm6Y5sBaTCZEYl7jmdGBLhM/x
         Pw1c236aTj1W4frt7uYPg6VTyP5jCnC58/2zLeRBr09pM6eYA3uGq/LonzOju6X6ElAQ
         2Nuw==
X-Forwarded-Encrypted: i=1; AJvYcCVen2FzWlG+B4aHaJAJHN2SBUXqmTuouYN8UobG6XHaZ5++DnMJ6z2NJY0+MP2NHGejz1utQMByEQzuAektds3Mjl5h7M1l5Tnqiccn
X-Gm-Message-State: AOJu0YzUiRaOCLwJsrTgb4llY3pDepFY7zgjRQFou94UD+fZwhj3WTnq
	JubEvfUvMVoFaE8CNKifXI4xtMIS9nkNA0OFu48lt8PbJCtb01VgR/Ma6wF7jryCTf2yQKc7jTU
	alRQNEz7GWgDZRz2nGtRUp08op38MEuwyAWZlmyDEAiW6+U8OFcyuHaKkCCJ6OQ==
X-Received: by 2002:a19:ac4b:0:b0:52c:84a2:d848 with SMTP id 2adb3069b0e04-52eb99d5f90mr212443e87.65.1720469159543;
        Mon, 08 Jul 2024 13:05:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOutunBjtATYlYPcPc2RtJuaPBHwhpp2F+6BNL1SdYd55rueYzXjB88TMPhrVMThULXxhZ7w==
X-Received: by 2002:a19:ac4b:0:b0:52c:84a2:d848 with SMTP id 2adb3069b0e04-52eb99d5f90mr212419e87.65.1720469159140;
        Mon, 08 Jul 2024 13:05:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:2200:bad7:95bd:e25e:a9e? (p200300cbc7442200bad795bde25e0a9e.dip0.t-ipconnect.de. [2003:cb:c744:2200:bad7:95bd:e25e:a9e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5a27sm10282465e9.23.2024.07.08.13.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 13:05:58 -0700 (PDT)
Message-ID: <3492ea69-54cd-4ba3-b328-2e76542ccc32@redhat.com>
Date: Mon, 8 Jul 2024 22:05:57 +0200
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de,
 linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
References: <20240707002658.1917440-1-Jason@zx2c4.com>
 <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
 <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
 <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
 <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
 <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
 <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
 <7439da2e-4a60-4643-9804-17e99ce6e312@redhat.com>
 <8bf64731-9e5c-4c8c-b46b-5b18ae3110a1@redhat.com>
 <ZovwO8KJ5Cv5fa26@zx2c4.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZovwO8KJ5Cv5fa26@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.24 15:57, Jason A. Donenfeld wrote:
> On Mon, Jul 08, 2024 at 10:23:10AM +0200, David Hildenbrand wrote:
>>> As a side note, I'll raise that I am not a particular fan of the
>>> "droppable" terminology, at least with the "read 0s" approach.
>>>
>>>    From a user perspective, the memory might suddenly lose its state and
>>> read as 0s just like volatile memory when it loses power. "dropping
>>> pages" sounds more like an implementation detail.
>>
>> Long story short: it's the hypervisor that could be effectively
>> dropping/zeroing out that memory, not the guest VM. "NONVOLATILE" might
>> be clearer than "DROPPABLE".
> 
> Surely you mean "VOLATILE", not "NONVOLATILE", right?

Yes, typo :)

-- 
Cheers,

David / dhildenb


