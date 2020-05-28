Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E1D1E58B2
	for <lists+linux-crypto@lfdr.de>; Thu, 28 May 2020 09:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgE1Hdu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 28 May 2020 03:33:50 -0400
Received: from 8bytes.org ([81.169.241.247]:45176 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgE1Hdu (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 28 May 2020 03:33:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B776F327; Thu, 28 May 2020 09:33:45 +0200 (CEST)
Date:   Thu, 28 May 2020 09:33:44 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200528073344.GO5221@8bytes.org>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
 <20200527181842.GA256680@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527181842.GA256680@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, May 27, 2020 at 01:18:42PM -0500, Bjorn Helgaas wrote:
> Is this slowdown significant?  We already iterate over every device
> when applying PCI_FIXUP_FINAL quirks, so if we used the existing
> PCI_FIXUP_FINAL, we wouldn't be adding a new loop.  We would only be
> adding two more iterations to the loop in pci_do_fixups() that tries
> to match quirks against the current device.  I doubt that would be a
> measurable slowdown.

I don't know how significant it is, but I remember people complaining
about adding new PCI quirks because it takes too long for them to run
them all. That was in the discussion about the quirk disabling ATS on
AMD Stoney systems.

So it probably depends on how many PCI devices are in the system whether
it causes any measureable slowdown.

Regards,

	Joerg

