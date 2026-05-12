Return-Path: <linux-crypto+bounces-23951-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGsdM9ISA2r20AEAu9opvQ
	(envelope-from <linux-crypto+bounces-23951-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 12 May 2026 13:45:22 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3457A51F8A5
	for <lists+linux-crypto@lfdr.de>; Tue, 12 May 2026 13:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98C98301CCC1
	for <lists+linux-crypto@lfdr.de>; Tue, 12 May 2026 11:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2409360ED9;
	Tue, 12 May 2026 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KEweNcFX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0J342uiq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KEweNcFX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0J342uiq"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E1360ED0
	for <linux-crypto@vger.kernel.org>; Tue, 12 May 2026 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586165; cv=none; b=nJ678WowNJmONZKO1c9yoCc+N8MwopUWgPaCGVdZfL3Ya1wWMX24L6oM4kOsTtoHxvkt/c7bdarasn04u70gIj7TbSijH75SfbLpkUaVVbf73zZbhKqtrdelWCzAewBbv53cIdU4Gcb4rGPFh1JFHYzC1g24dFB46WDgOqIxj/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586165; c=relaxed/simple;
	bh=HOKkDeeqlSpCzlTTBisOlKHbEWYFncII5EuW97xNlKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATACWRPxDHxKyPBE87bNbk/d1LNzYdvLfOmJXyhSOyvZhpBll1zdEWCex5+SLn3HioDzBeyRJ0v9hKbyFN91A05ECRZ1TneAfLnGnXPjfsSgdtRu17Tx1iJfp53aOznKYkn/djz99jMxmNdNt5PNFEDkh6vuYhoTriHgGm5lYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KEweNcFX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0J342uiq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KEweNcFX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0J342uiq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34B7376120;
	Tue, 12 May 2026 11:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778586161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLgB5RUZcid9XLsWsmXqzit5YR0tRKGHMrKjGe72tnI=;
	b=KEweNcFXbI/4awwwikZwQpLsJhqdcKP/ND/eEIHZpMVZYswHjsmnrwZiU2bxaD8n1OK0IS
	Kc6YjC0sw7nAn6qO/p47INirDH4cevpavEC2j0COzrDVxJtWpDOoi9k2FZAGtUc4QSsWyH
	YY7KnSMmVLtonjV5smZq449Ls/XSOCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778586161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLgB5RUZcid9XLsWsmXqzit5YR0tRKGHMrKjGe72tnI=;
	b=0J342uiqkSfyW8DZyH8r4hsv6i4foe07KIq12qtoXRLRS5m/d+XbyypVqVX3QbmZPnqRJi
	sxhM5qcbrx7pPCAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778586161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLgB5RUZcid9XLsWsmXqzit5YR0tRKGHMrKjGe72tnI=;
	b=KEweNcFXbI/4awwwikZwQpLsJhqdcKP/ND/eEIHZpMVZYswHjsmnrwZiU2bxaD8n1OK0IS
	Kc6YjC0sw7nAn6qO/p47INirDH4cevpavEC2j0COzrDVxJtWpDOoi9k2FZAGtUc4QSsWyH
	YY7KnSMmVLtonjV5smZq449Ls/XSOCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778586161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLgB5RUZcid9XLsWsmXqzit5YR0tRKGHMrKjGe72tnI=;
	b=0J342uiqkSfyW8DZyH8r4hsv6i4foe07KIq12qtoXRLRS5m/d+XbyypVqVX3QbmZPnqRJi
	sxhM5qcbrx7pPCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08727593A9;
	Tue, 12 May 2026 11:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rkjQATESA2rLPQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 12 May 2026 11:42:41 +0000
Date: Tue, 12 May 2026 13:42:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
Message-ID: <20260512114231.GG2558453@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260512052230.2947683-1-hch@lst.de>
 <20260512052230.2947683-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512052230.2947683-2-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -8.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 3457A51F8A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23951-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:replyto,lst.de:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 07:20:41AM +0200, Christoph Hellwig wrote:
> While the RAID6 algorithm could in theory support 3 devices by just
> copying the data disk to the two parity disks, this version is not only
> useless because it is a suboptimal version of 3-way mirroring, but also
> broken with various crashes and incorrect parity generation in various
> architecture-optimized implementations.  Disallow it similar to mdraid
> which requires at least 4 devices for RAID 6.
> 
> Fixes: 53b381b3abeb ("Btrfs: RAID5 and RAID6")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch should have been sent separately as it has user visible
impact and can potentially break some setups. The degenerate modes of
raid0, 5, or 6 are explicit as a possible middle step when converting
profiles.  We can use a fallback implementation for this case if the
accelerated implementations cannot do it.

