Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8B72D58FF
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Dec 2020 12:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbgLJLLN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Dec 2020 06:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbgLJLLC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Dec 2020 06:11:02 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF686C0613D6
        for <linux-crypto@vger.kernel.org>; Thu, 10 Dec 2020 03:10:21 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id a12so5031186wrv.8
        for <linux-crypto@vger.kernel.org>; Thu, 10 Dec 2020 03:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d7ICbgeRa9HWZM53L6FPnxQMWAPWR9TgfC0TXxGcXgY=;
        b=Y7E8EsSRlSiI1SKlfkm77fV6nbaNLGTDyBSWwv6ntHL2U2HSawwu3IVkGFzGepJTdP
         ZMQIVisdTXTOzlVShKl8xIHGOyeiXR4SMggIwsUs1L2lLN8mVpu5V17VachjC1pn02bp
         31mA4wtEG3mo/rz0Gdb/TRtvO//IVinAE8tg+PmnBjewPeO2OJzjTQfAbjTOO8M6krZE
         95ex5r0MLFPOMEDv0IzZnHfAZajJat0+1v+gji+o7ZbMRSN/Sv2PTxhmGifh5Yhyar0U
         0FaBhh4vH4wKn+QF+v1992doKWBnPBBLmgJkPGSfxfxCpLTaFSNLEou//OdLSvxF8Qw9
         Zokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=d7ICbgeRa9HWZM53L6FPnxQMWAPWR9TgfC0TXxGcXgY=;
        b=DBnbfxoTF1cHiTXHx1NfBR7+g2XU/TkoTnOvYhzq8I74X6J0t4woWaf3gQKWunUa0g
         cngggmN1U1ufX68SaQXOC5ZVGicPbk2PpVkOdAdnIG68zROI++IGceNMNcevvyZKhqZP
         YMy2vlCKDTMvLroGcEnVWqfQzqDVItfn9FB2MtdHPPgvKY+cuvpUVeaMsdpFWtrjV9gs
         vSxh/wmydeuIcZrr4qIM192ELfrRtV2iGp1mcBPxb+54t/dGdsjS3Bp4sl/DDSRCstM7
         ZasIGUSbsz1bPu2a2yTN7n+KPeqF2O6svE7WSKih2Eacj0xteh+2a6UWozJHtVQ217/f
         i8nA==
X-Gm-Message-State: AOAM531saJQ2CHiRJM9kjbKrfY4XmN3MYN7Co8aExH8PK/yyukv2fkNv
        RpEocMIn7xfiQ0kURWEaGN/7bg==
X-Google-Smtp-Source: ABdhPJzb7Ju0zEnjWKanAAII/6K9SrAT10GNT6ZVuqEpTJappgIgntBt89e5JFa/EzIeWnwxq6WuGw==
X-Received: by 2002:adf:fb88:: with SMTP id a8mr7665047wrr.412.1607598620562;
        Thu, 10 Dec 2020 03:10:20 -0800 (PST)
Received: from ?IPv6:2a01:e0a:410:bb00:111a:62e7:97b9:77f? ([2a01:e0a:410:bb00:111a:62e7:97b9:77f])
        by smtp.gmail.com with ESMTPSA id s13sm8523254wmj.28.2020.12.10.03.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 03:10:19 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2] xfrm: interface: Don't hide plain packets from
 netfilter
To:     Eyal Birger <eyal.birger@gmail.com>, Phil Sutter <phil@nwl.cc>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <20201207134309.16762-1-phil@nwl.cc>
 <CAHsH6Gupw7o96e5hOmaLBCZtqgoV0LZ4L7h-Y+2oROtXSXvTxw@mail.gmail.com>
 <20201208185139.GZ4647@orbyte.nwl.cc>
 <CAHsH6GvT=Af-BAWK0z_CdrYWPn0qt+C=BRjy10MLRNhLWfH0rQ@mail.gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <9fc5cbb8-26c7-c1c2-2018-3c0cd8c805f4@6wind.com>
Date:   Thu, 10 Dec 2020 12:10:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHsH6GvT=Af-BAWK0z_CdrYWPn0qt+C=BRjy10MLRNhLWfH0rQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Le 09/12/2020 à 15:40, Eyal Birger a écrit :
> Hi Phil,
> 
> On Tue, Dec 8, 2020 at 8:51 PM Phil Sutter <phil@nwl.cc> wrote:
>>
>> Hi Eyal,
>>
>> On Tue, Dec 08, 2020 at 04:47:02PM +0200, Eyal Birger wrote:
>>> On Mon, Dec 7, 2020 at 4:07 PM Phil Sutter <phil@nwl.cc> wrote:
[snip]
>>
>> The packet appears twice being sent to eth1, the second time as ESP
>> packet. I understand xfrm interface as a collector of to-be-xfrmed
>> packets, dropping those which do not match a policy.
>>
>>>> Fix this by looping packets transmitted from xfrm_interface through
>>>> NF_INET_LOCAL_OUT before passing them on to dst_output(), which makes
>>>> behaviour consistent again from netfilter's point of view.
>>>
>>> When an XFRM interface is used when forwarding, why would it be correct
>>> for NF_INET_LOCAL_OUT to observe the inner packet?
I think it is valid because:
 - it would be consistent with ip tunnels (see iptunnel_xmit())
 - it would be consistent with the standard xfrm path see [1]
 - from the POV of the forwarder, the packet is locally emitted, the src @ is
   owned by the forwarder.

[1] https://upload.wikimedia.org/wikipedia/commons/3/37/Netfilter-packet-flow.svg

>>
>> A valid question, indeed. One could interpret packets being forwarded by
>> those tunneling devices emit the packets one feeds them from the local
>> host. I just checked and ip_vti behaves identical to xfrm_interface
>> prior to my patch, so maybe my patch is crap and the inability to match
>> on ipsec context data when using any of those devices is just by design.
There was no real design for vti[6] interfaces, it's why xfrmi interfaces have
been added. But they should be consistent I think, so this patch should handle
xfrmi and vti[6] together.


Regards,
Nicolas

>>
> 
> I would find such interpretation and behavior to be surprising for an IPsec
> forwarder...
> I guess some functionality of policy matching is lost with these
> devices; although they do offer the ability to match ipsec traffic based on
> the destination interface it is possible to have multiple ipsec flows share
> the same device so netfilter doesn't provide the ability to distinguish
> between different flows on the outbound direction in such cases.
> 
> Thanks,
> Eyal.
> 
