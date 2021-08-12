Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4853EA4EA
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Aug 2021 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbhHLMvu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Aug 2021 08:51:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43590 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbhHLMvt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Aug 2021 08:51:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 917C21FF40;
        Thu, 12 Aug 2021 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628772683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6QEAh1eIqNKepUiekTGRyznT7B1JhNBAvXQNcKttlA=;
        b=XaDMFDs0JLJ/WihTtuUXRT9qj3ezAnx5udgeVirHc43CqgvA+tLVw+Rp1Kj5SynHAlug0O
        ID03MplJ0kkDJqZ1STPMCt27giYtCUe2gQ05W/uErcRh2QWLm667KJy7DbR11DaIudIXQ9
        z/CC9KU301+kUwZaxTHRBjYw9n5t6TA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628772683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6QEAh1eIqNKepUiekTGRyznT7B1JhNBAvXQNcKttlA=;
        b=DF4tXYn6vJUkrex6aNgV9b0t8rxhxsBJM3Xdpa5bsjyPzHPaS8rMNe3XdwUWXfBiApdZ1i
        WJJ/ByTUF348vSAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83AB513C49;
        Thu, 12 Aug 2021 12:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ph2sH0sZFWF9bgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 Aug 2021 12:51:23 +0000
Subject: Re: [PATCH 13/13] nvme: add non-standard ECDH and curve25517
 algorithms
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
References: <20210810124230.12161-1-hare@suse.de>
 <20210810124230.12161-14-hare@suse.de> <20210812122518.GA19050@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b009d8f9-cf6b-ef1c-51fc-5bd7f69c2c9e@suse.de>
Date:   Thu, 12 Aug 2021 14:51:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812122518.GA19050@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 8/12/21 2:25 PM, Christoph Hellwig wrote:
> On Tue, Aug 10, 2021 at 02:42:30PM +0200, Hannes Reinecke wrote:
>> TLS 1.3 specifies ECDH and curve25517 in addition to the FFDHE
>> groups, and these are already implemented in the kernel.
>> So add support for these non-standard groups for NVMe in-band
>> authentication to validate the augmented challenge implementation.
> 
> If you think these are useful please add them to the standard.
> 
Ok, will be omitting that patch for the next submission.
I've just added them for validation of the DH exchange; but now
that ffdhe seems to be reasonably stable I don't have an issue with
dropping them.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
