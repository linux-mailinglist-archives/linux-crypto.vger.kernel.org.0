Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF94F7DCFE5
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Oct 2023 16:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjJaPHk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 31 Oct 2023 11:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjJaPHj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 31 Oct 2023 11:07:39 -0400
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 08:07:37 PDT
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976369F
        for <linux-crypto@vger.kernel.org>; Tue, 31 Oct 2023 08:07:37 -0700 (PDT)
Message-ID: <24f65f57980f7010cdc44f17023d475b.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1698764258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mwcYmzMGLrIJAKwwPAsSOg0b5letFz0OQC+Kd8SAaXA=;
        b=I1e1Nm3/SfRhcsEPVlr3BsdMch/5F6GBpdFrsAg1JJujq9CXM8y4rxR24iCsA7o6/kyGZp
        1eCCN7BrEhrlr29kw8EycGIAC+5VDuUcJYePQHMu2vEAmJ4yxojoixAajxg0pawMUhgVTX
        QDBrcp7oSZRLbOeOSt7aOJyvxUcicZECrSuV0JKJEDb6DYVjDr21xE7l+QvMMYABmigplc
        1AfzaAYXQ6e8jTxHcF/kWRS333VQxMV5+N5KodR26RDwk7QubXRb6jXNnXjJsdQLu+XTkp
        Nf4mYapUIelWMsR6I/nkAX8L5IccpK/9kI4hTmeWRvj/Fbm/AJn6/sj1G1lvTA==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1698764258; a=rsa-sha256;
        cv=none;
        b=i9bohQPBrDXw9uor/Yysn5EWlj4iUdv06t7PRa/UiMtTBkwnQGge9pdjQJ7Hr8Xo2+WfyW
        SieYjt/UzTwhv/9WosiDwa+kun/pe0Z/IjNKc2fZh99Qv/HkIFTw7fCrLyIDgjdacLaGrN
        Rn9CgiFZozdDnrPWH/jjr1OOL7SxCqPXFMXu4hMA1CxTniOzpzVWDGXkuHOBe+VCmGx6BT
        cuosu+OfgYR0WR54D6OHSv65Cm+flu3+5SCyeQHx+grfkHOhnRC12eP3K/J7c7csP1zH3W
        VJ9Cfisoru1tmYPhBa9Mu4fPdfjldAJE3wfeQABw9KWg2Ofd9ojtH76FtOovPg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1698764258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mwcYmzMGLrIJAKwwPAsSOg0b5letFz0OQC+Kd8SAaXA=;
        b=VdZSD1LxJvjK1IQrc4FCTSyQxFh1H5WvOt5KnTyBWEXhcC4ghqf1GKZrrG9YF5/S9sPf6E
        mffkbQaRcqyisi6hXv0k4N3cjRcZVVgS5K1Jn8EsFN3fYV+ZRUeFDgqLtLIpT/F+CFSOq1
        P8NibH9fLliAA47kBmqFGG9sGy0OT5Jr+oGkvDRZaBZa8am/gcvTGpenflRKK4mzZ+kXv/
        +sbZjFouzCUDeI8IkKk1wKIyheRybaI9KkOKSXSKwwtg6+cIBF3MS+OLd1V5h45cBZGwsw
        kTcjrWtxPpG4a357qe2phi913waBylEG2q5+mzCBqdLDiUShTaah+tIhQTMmHw==
From:   Paulo Alcantara <pc@manguebit.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] smb: use crypto_shash_digest() in symlink_hash()
In-Reply-To: <20231029050300.154832-1-ebiggers@kernel.org>
References: <20231029050300.154832-1-ebiggers@kernel.org>
Date:   Tue, 31 Oct 2023 11:57:33 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> From: Eric Biggers <ebiggers@google.com>
>
> Simplify symlink_hash() by using crypto_shash_digest() instead of an
> init+update+final sequence.  This should also improve performance.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/smb/client/link.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/fs/smb/client/link.c b/fs/smb/client/link.c
> index c66be4904e1f..a1da50e66fbb 100644
> --- a/fs/smb/client/link.c
> +++ b/fs/smb/client/link.c

Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
