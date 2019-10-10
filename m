Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58597D33ED
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Oct 2019 00:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfJJW3V (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Oct 2019 18:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfJJW3V (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Oct 2019 18:29:21 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5BF5206B6;
        Thu, 10 Oct 2019 22:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570746560;
        bh=k6lPg3kANWXVQOMFYTyKPj4cst91ZM8Y9L5PaiqB0Qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SvvoqoJsSiUrgO9uM21ZsCo56zIsh3pJpsAuKjixkiwlX2wIKWBWzhzMJv/UgBTyJ
         V8MkkbRBX5TAwQq135uZWXY0C7bMEJ17a2V4jXDmAkmGrweJp4JqGGZJCXu2tKLOLS
         +tF5VM7IlcyxtZx6U2PnHGbf0HwUiAjNw9Ru3hEM=
Date:   Thu, 10 Oct 2019 15:29:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-crypto@vger.kernel.org, ard.biesheuvel@linaro.org
Subject: Re: [PATCH v3] crypto: add blake2b generic implementation
Message-ID: <20191010222918.GC143518@gmail.com>
Mail-Followup-To: David Sterba <dsterba@suse.com>,
        linux-crypto@vger.kernel.org, ard.biesheuvel@linaro.org
References: <e7f46def436c2c705c0b2cac3324f817efa4717d.1570715842.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f46def436c2c705c0b2cac3324f817efa4717d.1570715842.git.dsterba@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

A couple more comments:

On Thu, Oct 10, 2019 at 04:10:05PM +0200, David Sterba wrote:
> +static void blake2b_set_lastnode(struct blake2b_state *S)
> +{
> +	S->f[1] = (u64)-1;
> +}
> +
[...]
> +static void blake2b_set_lastblock(struct blake2b_state *S)
> +{
> +	if (S->last_node)
> +		blake2b_set_lastnode(S);
> +

last_node is never true, so this is dead code.

> +struct digest_desc_ctx {
> +	struct blake2b_state S[1];
> +};

This indirection isn't needed.  Just use struct blake2b_state directly as the
shash_desc_ctx.

- Eric
