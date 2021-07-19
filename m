Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479ED3CD42D
	for <lists+linux-crypto@lfdr.de>; Mon, 19 Jul 2021 13:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhGSLL7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 19 Jul 2021 07:11:59 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:8034 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhGSLL6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 19 Jul 2021 07:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626695555;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hf47HkIPWtAcLkubNl+xFO6GIE/eA5xPlwVuQPPhhUc=;
    b=RlzlYHVzcDwBjMTt7O3WtE8tVc+OCheeNZ9brbbZ8OgCmQL/7OqFxzAacWeDq/A3f0
    qdqQni4vXAa6m+BiezMmmHAvn20X5un9b+UAfHsNt4afYaS++f15hzHBwOc1nxUO0Gre
    hNVPCaRztVVVIj8AjjHm+BQiev56hQhxcA9eW9ym4diZdBfDKDFhzx2PpbsyxeIL+Lua
    e0ZKUNHugleIhZDQUxb4kzRJSdlrTMGIw9q0F5wtte80dIECFjFsSUag01TSCGBRAn0C
    zTfa/qVpalxo1XKe4KhiRQUnKGyDvDZ9AdI3UsQyd1gQDnlCP6stz4b7aF2qTHfkI+r3
    IJPQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNzyCzy1Sfr67uExK884EC0GFGHavJSlBkMRYMkE="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
    with ESMTPSA id 9043bbx6JBqYI3k
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jul 2021 13:52:34 +0200 (CEST)
Message-ID: <24d115c9b68ca98a3cf363e1cfcb961cc6b38069.camel@chronox.de>
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
From:   Stephan Mueller <smueller@chronox.de>
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>,
        linux-nvme@lists.infradead.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Date:   Mon, 19 Jul 2021 13:52:33 +0200
In-Reply-To: <1eab1472-3b7b-307b-62ae-8bed39603b96@suse.de>
References: <20210716110428.9727-1-hare@suse.de>
         <2510347.locV8n3378@positron.chronox.de>
         <a4d4bda0-2bc8-0d0c-3e81-55adecd6ce52@suse.de>
         <6538288.aohFRl0Q45@positron.chronox.de>
         <59695981-9edc-6b7a-480a-94cca95a0b8c@suse.de>
         <463a191b9896dd708015645cfc125988cd5deaef.camel@chronox.de>
         <2af95a8e-50d9-7e2d-a556-696e9404fee4@suse.de>
         <740af9f7334c294ce879bef33985dfab6d0523b3.camel@chronox.de>
         <1eab1472-3b7b-307b-62ae-8bed39603b96@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Am Montag, dem 19.07.2021 um 13:10 +0200 schrieb Hannes Reinecke:
> On 7/19/21 12:19 PM, Stephan Mueller wrote:
> > Am Montag, dem 19.07.2021 um 11:57 +0200 schrieb Hannes Reinecke:
> > > On 7/19/21 10:51 AM, Stephan Mueller wrote:
> > > > Am Montag, dem 19.07.2021 um 10:15 +0200 schrieb Hannes Reinecke:
> > > > > On 7/18/21 2:56 PM, Stephan Müller wrote:
> > > > > > Am Sonntag, 18. Juli 2021, 14:37:34 CEST schrieb Hannes Reinecke:
> > > > 
> > > > > > > The key is also used when using the ffdhe algorithm.
> > > > > > > Note: I _think_ that I need to use this key for the ffdhe
> > > > > > > algorithm,
> > > > > > > because the implementation I came up with is essentially plain
> > > > > > > DH
> > > > > > > with
> > > > > > > pre-defined 'p', 'q' and 'g' values. But the DH implementation
> > > > > > > also
> > > > > > > requires a 'key', and for that I'm using this key here.
> > > > > > > 
> > > > > > > It might be that I'm completely off, and don't need to use a key
> > > > > > > for
> > > > > > > our
> > > > > > > DH implementation. In that case you are correct.
> > > > > > > (And that's why I said I'll need a review of the FFDHE
> > > > > > > implementation).
> > > > > > > But for now I'll need the key for FFDHE.
> > > > > > 
> > > > > > Do I understand you correctly that the dhchap_key is used as the
> > > > > > input
> > > > > > to
> > > > > > the 
> > > > > > DH - i.e. it is the remote public key then? It looks strange that
> > > > > > this
> > > > > > is
> > > > > > used 
> > > > > > for DH but then it is changed here by hashing it together with
> > > > > > something
> > > > > > else 
> > > > > > to form a new dhchap_key. Maybe that is what the protocol says.
> > > > > > But it
> > > > > > sounds 
> > > > > > strange to me, especially when you think that dhchap_key would be,
> > > > > > say,
> > > > > > 2048 
> > > > > > bits if it is truly the remote public key and then after the
> > > > > > hashing
> > > > > > it is
> > > > > > 256 
> > > > > > this dhchap_key cannot be used for FFC-DH.
> > > > > > 
> > > > > > Or are you using the dhchap_key for two different purposes?
> > > > > > 
> > > > > > It seems I miss something here.
> > > > > > 
> > > > > No, not entirely. It's me who buggered it up.
> > > > > I got carried away by the fact that there is a
> > > > > crypto_dh_encode_key()
> > > > > function, and thought I need to use it here.
> > > > 
> > > > Thank you for clarifying that. It sounds to me that there is no
> > > > defined
> > > > protocol (or if there, I would be wondering how the code would have
> > > > worked
> > > > with a different implementation). Would it make sense to first specify
> > > > a
> > > > protocol for authentication and have it discussed? I personally think
> > > > it
> > > > is a
> > > > bit difficult to fully understand the protocol from the code and
> > > > discuss
> > > > protocol-level items based on the code.
> > > > 
> > > Oh, the protocol _is_ specified:
> > > 
> > >  
> > > https://nvmexpress.org/wp-content/uploads/NVM-Express-Base-Specification-2_0-2021.06.02-Ratified-5.pdf
> > > 
> > > It's just that I have issues translating that spec onto what the kernel
> > > provides.
> > 
> > according to the naming conventions there in figures 447 and following:
> > 
> > - x and y: DH private key (kernel calls it secret set with dh_set_secret
> > or
> > encoded into param.key)
> > 
> 
> But that's were I got confused; one needs a private key here, but there
> is no obvious candidate for it. But reading it more closely I guess the
> private key is just a random number (cf the spec: g^y mod p, where y is
> a random number selected by the host that shall be at least 256 bits
> long). So I'll fix it up with the next round.

Here comes the crux: the kernel has an ECC private key generation function
ecdh_set_secret triggered with crypto_kpp_set_secret using a NULL key, but it
has no FFC-DH counterpart.

That said, generating a random number is the most obvious choice, but not the
right one.

The correct one would be following SP800-56A rev 3 and here either section
5.6.1.1.3 or 5.6.1.1.4.

Ciao
Stephan
> 
> > - g^x mod p  / g^y mod p: DH public keys from either end that is
> > communicated
> > over the wire (corresponding to the the DH private keys of x and y) - to
> > set
> > it, you initialize a dh request and set the public key to it with
> > kpp_request_set_input. After performing the
> > crypto_kpp_compute_shared_secret
> > you receive the shared secret
> > 
> > - g^xy mod p: DH shared secret - this is the one that is to be used for
> > the
> > subsequent hashing /HMAC operations as this is the one that is identical
> > on
> > both, the host and the controller.
> > 
> Thanks. Will be checking the code if I do it correctly.
> 
> Cheers,
> 
> Hannes


