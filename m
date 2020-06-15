Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66991FA025
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2020 21:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgFOT0D (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Jun 2020 15:26:03 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:35370 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbgFOT0D (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Jun 2020 15:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1592249161;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=wrQTq2V257VK66v6YOYTmaDSMmIDbXHY8G1KxjTD23k=;
        b=pFlyRnk7/UBHyEUCPKzLetgTlbJ5pwCwHo6PuS5n76z6Fsic6HrTU61ZQ93Lri3DeS
        gdiB9rEX8JB8tQeylGdDwlcLwQdgvYKrDS3mMNVWIt2rAGkadzsctT4+5XeVLpuZPbR7
        j2OVrzU30bQzV0nDaLJQouJH+e9QQP/Y1iDEGdduGhZU3WtBLMkZnbhtGjbwLMOWyGsh
        rmlc/RXROlvGOv4tdaYAM061aij0ryyI+r2AEFZtdNvC917WFN2w88ORi1eQeaHfZdyI
        fr5NlzlgoPaWCwBVvcEg+cmP5UCUY5OXSW6C7xXnd9lQanKgUkVYTtdsHvLHYHfpfFXU
        Bmqg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaJfSc9CNS"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.10.4 DYNA|AUTH)
        with ESMTPSA id U03fedw5FJPwCLn
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 15 Jun 2020 21:25:58 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Anshuman Gupta <anshuman.gupta@intel.com>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [Query] RSA SHA-384 signature verification
Date:   Mon, 15 Jun 2020 21:25:58 +0200
Message-ID: <1730161.mygNopSbl3@tauon.chronox.de>
In-Reply-To: <20200615170413.GF14085@intel.com>
References: <20200615170413.GF14085@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Am Montag, 15. Juni 2020, 19:04:14 CEST schrieb Anshuman Gupta:

Hi Anshuman,

> Hi ,
> I wanted to verify a RSA SHA-384 signature.
> I am using crypto_alloc_shash(), crypto_shash_digest() API to extract
> the SHA-384 digest.
> I am having public key along with the sha-384 digest extracted from raw data
> and signature. AFAIU understand from crypto documentation that i need to
> verify the signature by importing public key to akcipher/skcipher API.
> Here i am not sure which cipher API to prefer symmetric key cipher or
> asymmetric key cipher API.
> 
> There are two types of API to import the key.
> crypto_skcipher_setkey()
> crypto_akcipher_set_pub_key()
> 
> Also i am not sure exactly which algo to use for RSA-SHA384 signature
> verification.
> 
> Any help or inputs from crypto community will highly appreciated.

akcipher: asymmetric key crypto

skcipher: symmetric key crypto
> 
> Thanks ,
> Anshuman Gupta.


Ciao
Stephan


