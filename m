Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A89CB187
	for <lists+linux-crypto@lfdr.de>; Thu,  3 Oct 2019 23:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfJCVva (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 3 Oct 2019 17:51:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:32422 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfJCVva (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 3 Oct 2019 17:51:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 14:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="191393096"
Received: from okiselev-mobl1.ccr.corp.intel.com (HELO localhost) ([10.251.93.117])
  by fmsmga008.fm.intel.com with ESMTP; 03 Oct 2019 14:51:26 -0700
Date:   Fri, 4 Oct 2019 00:51:25 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     David Safford <david.safford@ge.com>,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-ID: <20191003215125.GA30511@linux.intel.com>
References: <20190926171601.30404-1-jarkko.sakkinen@linux.intel.com>
 <1570024819.4999.119.camel@linux.ibm.com>
 <20191003114119.GF8933@linux.intel.com>
 <1570107752.4421.183.camel@linux.ibm.com>
 <20191003175854.GB19679@linux.intel.com>
 <1570128827.5046.19.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570128827.5046.19.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Oct 03, 2019 at 02:53:47PM -0400, Mimi Zohar wrote:
> [Cc'ing David Safford]
> 
> On Thu, 2019-10-03 at 20:58 +0300, Jarkko Sakkinen wrote:
> > On Thu, Oct 03, 2019 at 09:02:32AM -0400, Mimi Zohar wrote:
> > > On Thu, 2019-10-03 at 14:41 +0300, Jarkko Sakkinen wrote:
> > > > On Wed, Oct 02, 2019 at 10:00:19AM -0400, Mimi Zohar wrote:
> > > > > On Thu, 2019-09-26 at 20:16 +0300, Jarkko Sakkinen wrote:
> > > > > > Only the kernel random pool should be used for generating random numbers.
> > > > > > TPM contributes to that pool among the other sources of entropy. In here it
> > > > > > is not, agreed, absolutely critical because TPM is what is trusted anyway
> > > > > > but in order to remove tpm_get_random() we need to first remove all the
> > > > > > call sites.
> > > > > 
> > > > > At what point during boot is the kernel random pool available?  Does
> > > > > this imply that you're planning on changing trusted keys as well?
> > > > 
> > > > Well trusted keys *must* be changed to use it. It is not a choice
> > > > because using a proprietary random number generator instead of defacto
> > > > one in the kernel can be categorized as a *regression*.
> > > 
> > > I really don't see how using the TPM random number for TPM trusted
> > > keys would be considered a regression.  That by definition is a
> > > trusted key.  If anything, changing what is currently being done would
> > > be the regression. 
> > 
> > It is really not a TPM trusted key. It trusted key that gets sealed with
> > the TPM. The key itself is used in clear by kernel. The random number
> > generator exists in the kernel to for a reason.
> > 
> > It is without doubt a regression.
> 
> You're misusing the term "regression" here.  A regression is something
> that previously worked and has stopped working.  In this case, trusted
> keys has always been based on the TPM random number generator.  Before
> changing this, there needs to be some guarantees that the kernel
> random number generator has a pool of random numbers early, on all
> systems including embedded devices, not just servers.

I'm not using the term regression incorrectly here. Wrong function
was used to generate random numbers for the payload here. It is an
obvious bug.

/Jarkko
