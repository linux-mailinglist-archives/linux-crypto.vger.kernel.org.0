Return-Path: <linux-crypto+bounces-5485-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F2092AA52
	for <lists+linux-crypto@lfdr.de>; Mon,  8 Jul 2024 22:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E35B1F2312F
	for <lists+linux-crypto@lfdr.de>; Mon,  8 Jul 2024 20:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F6A37703;
	Mon,  8 Jul 2024 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLwPScXE"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B9225AF
	for <linux-crypto@vger.kernel.org>; Mon,  8 Jul 2024 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469211; cv=none; b=Dgm1kY08e8ngFL988iKerMCSvDlo2vjRzuJMymvSHYrZEWg0/Mk2aIcY/kSY7c/timvCb/5V8HwRjiTLDK7KatM9Z+y1vVK4vIs9yPW2r6vrYg7a5NUgYMrY+Nezle9wPfixiP6erd3KfB9YpoJ9mOkfAeAZnZMugFJh6HoHUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469211; c=relaxed/simple;
	bh=lopMJKNUkM5mdilFcbxOlowjhB72XNJu1hZbshGnERQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfBbV8w91io2TM2P/Olbvn6DDq4BO47/t+N/J5RJEJMFoOMAsJtQZtLuaox5t+kaFRnUt0aQ73VfiThjb9iMmD9kOT0hL2BhmHytAyGzH+Xp7kI21MTM0XkiWA/I+KUcAyCzNHcEk5NgOqmRqb3cJKr2v0gWcjFXCfnE6xXpLG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLwPScXE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720469209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ufhtylmYb0l9ME9pQ71j54Ozfhc8pZ6jpAyIxmjbQ/M=;
	b=KLwPScXEUMmF0H/xCn1qH5R3zeq97OsUYCnTiCHl9tGZZdQgRv2/rzQ9CQqNzvsYFFSerr
	5Ezu9p1uENGRqO50ykSq+B3sZmr4mRVlG+k/VprAbD/l1LuLTrQKz8TmAkyL2zqdtm2U8k
	Jseo8uWFTWdJABQKKwSXzhxKeoHcL58=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-KQmow9GQMXKLYBGN2_XmtA-1; Mon, 08 Jul 2024 16:06:47 -0400
X-MC-Unique: KQmow9GQMXKLYBGN2_XmtA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42668796626so10756765e9.0
        for <linux-crypto@vger.kernel.org>; Mon, 08 Jul 2024 13:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720469205; x=1721074005;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ufhtylmYb0l9ME9pQ71j54Ozfhc8pZ6jpAyIxmjbQ/M=;
        b=e38uiHBDAG8bhNxi8cR6SA7AitWnr/cg4CgGh5MfYOPvEVQxocJLXcYps5xuG4RtIO
         niM9vG+DqnTOIvKLo1ftWwWrdNJsrR+Fmf2qwps65FcpaAzwlEzZF8BNti7hqSDVRWO0
         U8C4F4rjskZfqTJFjyr+99bpxIPD0MXa2BdDlzWSmt/NPZPx5SZlb2u11pO9cBOoU4mu
         i7sqimQTjPLxcL4ykIK9FIz7DdTzAa3ZEObvY+yNRjsqsejda4ay6YkfEh8i0IuXPlj0
         ysiV9PBTjH0Tzfgf/L1b7fv5mzCu101N7ZMOFoTFrV0vq8jhGeWMw/Ag6b8xJ5xP91n4
         HVsg==
X-Forwarded-Encrypted: i=1; AJvYcCU9VF6TZZmobGHbpZhKTJ9KFV6uoNUlu+Dn/nEczqVEbmpNbQNkJHUBAiiCspzb3xaN8miOcf4xCoAEUj7tZmHqkr/YO26rVD/hlaZV
X-Gm-Message-State: AOJu0YzgzUQzDCNyc1hGq80HXK/b6YpfguHxcb+8A4V2ZInab7G/ZxJl
	VT4WLKK/yVnIxdiF5AnlAFOc/Q9FduULP059L17eowTXiG75Q7obF+qquaVxBIXFki5CXNIzDGo
	ktIcGhuAX+bEct74mcXu3ksNKpqlycLrJm9DTg0rCpMyxv3YrepfeEx1iOEnGjw==
X-Received: by 2002:a05:600c:896:b0:426:64a2:5375 with SMTP id 5b1f17b1804b1-426707cbf60mr4187785e9.1.1720469205664;
        Mon, 08 Jul 2024 13:06:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY3cy8KO7R2bm9GD3OsyrOijDD4r+Wzecwv9hQQdddOHxtAoBS7yAbuwECbpXjcjqzix6Adw==
X-Received: by 2002:a05:600c:896:b0:426:64a2:5375 with SMTP id 5b1f17b1804b1-426707cbf60mr4187585e9.1.1720469205258;
        Mon, 08 Jul 2024 13:06:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:2200:bad7:95bd:e25e:a9e? (p200300cbc7442200bad795bde25e0a9e.dip0.t-ipconnect.de. [2003:cb:c744:2200:bad7:95bd:e25e:a9e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5f25sm10628625e9.26.2024.07.08.13.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 13:06:44 -0700 (PDT)
Message-ID: <75cf01cd-8a45-4a79-b06c-cdf2d68cdd53@redhat.com>
Date: Mon, 8 Jul 2024 22:06:43 +0200
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
 <Zovv4lzM38EHtnms@zx2c4.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zovv4lzM38EHtnms@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.24 15:55, Jason A. Donenfeld wrote:
> Hi David,
> 
> On Mon, Jul 08, 2024 at 10:11:24AM +0200, David Hildenbrand wrote:
>> The semantics are much more intuitive. No need for separate mmap flags.
> 
> Agreed.
>   
>> Likely we'll have to adjust mlock() as well. Also, I think we should
>> just bail out with hugetlb as well.
> 
> Ack.
> 
>> Further, maybe we want to disallow madvise() clearing these flags here,
>> just to be consistent.
> 
> Good thinking.
> 
>> As a side note, I'll raise that I am not a particular fan of the
>> "droppable" terminology, at least with the "read 0s" approach.
>>
>>   From a user perspective, the memory might suddenly lose its state and
>> read as 0s just like volatile memory when it loses power. "dropping
>> pages" sounds more like an implementation detail.
>>
>> Something like MAP_VOLATILE might be more intuitive (similar to the
>> proposed MADV_VOLATILE).
>>
>> But naming is hard, just mentioning to share my thought :)
> 
> Naming is hard, but *renaming* is annoying. I like droppable simply
> because that's what I've been calling it in my head. MAP_VOLATILE is
> fine with me though, and seems reasonable enough. So I'll name it that,
> and then please don't change your mind about it later so I won't have to
> rename everything again. :)

:) Nah. But wait with any remaining until more than one person thinks 
it's a good idea.

-- 
Cheers,

David / dhildenb


