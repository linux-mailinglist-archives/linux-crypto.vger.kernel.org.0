Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F6C63D96E
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Nov 2022 16:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiK3P3u (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 30 Nov 2022 10:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiK3P3t (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 30 Nov 2022 10:29:49 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA5E4F1B5;
        Wed, 30 Nov 2022 07:29:48 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2A59C320046E;
        Wed, 30 Nov 2022 10:29:47 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 30 Nov 2022 10:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669822186; x=1669908586; bh=cQmMnP4VZD
        sFwEhmSshAvzwxcmvmKRmn3yle98I76AQ=; b=aOTWwzuTKU7DDg+Kx8uwybGpGc
        5n77QCfJn6GjKMCVv7Bd5pIHGfTLtVLmZhA0T84ylBk1kuieitVOIhWFViBVzdu/
        X1VVcSMnkfYuTXO9Zh0GaL4rh5jzxG27TPzLnjaDPpc1mhjnY8Y/jh7PhKX0pFce
        ypfPUehmZ6c8kAh7a6fn19F/w9STz36JXYgLhH4Hm7QcyU4PGDJ83pJUhg8BsEo8
        WJlxwwTLYGGZOiD7BTmoR0h/Q8u4WoAXk+Jw/CVsSwRwHMuCXbVXCTSTmdSRiFFj
        wZ7gJNHu+as1T2vvufFVGEHPsT9z/NXCBRlBIBt81S2tX6mpmE/7ybN6nyaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669822186; x=1669908586; bh=cQmMnP4VZDsFwEhmSshAvzwxcmvm
        KRmn3yle98I76AQ=; b=kAMZsgcEo9hB5JgkVN6AY4zuD4A/rfXozApzsDnjYYmL
        EZLBpH5eUs+WbPVWOwat6Q7v1fkHLlgqE10e50re6BLQ3+S8U+OqTvgK0RTCH5xn
        vDXP5b1uH1W6kTbJB195vy5J+8vINzwdbYurGBgVBzfjJaAbCCD1m5HJArRQNuM9
        ni3rlso8bCngrcCmoX8PjLrUg2c+Md+ieL5T48V8MMRUBEJEGCNFraAj6G0ta1jg
        RRwi63hVCyUmHpUWNdX6MFgfEusGWGFob1KdFP+SZsmLFKJGnHJvxzmN94F7UXpA
        bH8UbeGM3jDG3y3L72oR//YyRsHwMPVGaSq0iZYiIQ==
X-ME-Sender: <xms:6naHY91ULeXGHf1WlO60V5umWGQ1h_xrWK8D5bSRKsAkDEcAM3l0XQ>
    <xme:6naHY0HMPXjXCxc0E4cEhEQHvnHBFr2Se_gOgAkE__bxnTwY-eigOrcJmICQDDeh8
    7jXRzsIeJW0R9ZUuSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdefgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6naHY961Hlno7SsXe26GW7bP7CTVrXAm8yXTUDdaKhyWUxCTdEqb8g>
    <xmx:6naHY61PBPuMq5_77E9py8ZFaXGcG3RjTwsYm1kLgSeM8_S04_wbmw>
    <xmx:6naHYwEfK3YLMv_mTG_RKmvn7hXXVzJHOjuEj-giMvsX7Wt2o3tl4g>
    <xmx:6naHY7C1MNzcP9Rw_vAKhF_S7AvPQJDrYy-2upMYEBIdETkQVJdrtw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 65099B60086; Wed, 30 Nov 2022 10:29:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <574ad32d-566e-4c18-a645-1470fc081ede@app.fastmail.com>
In-Reply-To: <CAHmME9rpdCGLQzfsNkX=mLHfWeEWi4TyrOf_2rP_9hsyX9v6ow@mail.gmail.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-4-Jason@zx2c4.com>
 <878rjs7mcx.fsf@oldenburg.str.redhat.com> <Y4dt1dLZMmogRlKa@zx2c4.com>
 <Y4dvz4d0dpFzJZ9L@zx2c4.com>
 <16ec2a7a-c469-4732-aeca-e74a9fb88d3e@app.fastmail.com>
 <CAHmME9rpdCGLQzfsNkX=mLHfWeEWi4TyrOf_2rP_9hsyX9v6ow@mail.gmail.com>
Date:   Wed, 30 Nov 2022 16:29:26 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     "Florian Weimer" <fweimer@redhat.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        "Thomas Gleixner" <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH v10 3/4] random: introduce generic vDSO getrandom() implementation
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 30, 2022, at 16:12, Jason A. Donenfeld wrote:
> Hi Arnd,
>
> On Wed, Nov 30, 2022 at 4:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> > +#ifdef CONFIG_64BIT
>> > +typedef u64 vdso_kernel_ulong;
>> > +#else
>> > +typedef u32 vdso_kernel_ulong;
>> > +#endif
>>
>> This does not address the ABI concern: to allow 32-bit and 64-bit
>> tasks to share the same data page, it has to be the same width on
>> both, either u32 or 64, but not depending on a configuration
>> option.
>
> I think it does address the issue. CONFIG_64BIT is a .config setting,
> not a compiler-derived setting. So a 64-bit kernel will get a u64 in
> kernel mode, and then it will get a u64 for the 64-bit vdso usermode
> compile, and finally it will get a u64 for the 32-bit vdso usermode
> compile. So in all three cases, the size is the same.

I see what you mean now. However this means your vdso32 copies
are different between 32-bit and 64-bit kernels. If you need to
access one of the fields from assembler, it even ends up
different at source level, which adds a bit of complexity.

Making the interface configuration-independent makes it obvious
to the reader that none of these problems can happen.

>> > struct vdso_rng_data {
>> >       vdso_kernel_ulong       generation;
>> >       bool                    is_ready;
>> > };
>>
>> There is another problem with this: you have implicit padding
>> in the structure because the two members have different size
>> and alignment requirements. The easiest fix is to make them
>> both u64, or you could have a u32 is_ready and an explit u32
>> for the padding.
>
> There's padding at the end of the structure, yes. But both
> `generation` and `is_ready` will be at the same offset. If the
> structure grows, then sure, that'll have to be taken into account. But
> that's not a problem because this is a private implementation detail
> between the vdso code and the kernel.

I was not concerned about incompatibility here, but rather about
possibly leaking kernel data to the vdso page. Again, this probably
doesn't happen if your code is written correctly, but the rule for
kernel-user ABIs is to avoid implicit padding to ensure that
the padding bytes can never leak any information. Using structures
without padding at the minimum helps avoid having to think about
whether this can become a problem when inspecting the code for
possible issues, both from humans and from automated tools.

     Arnd
