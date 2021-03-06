/*
 * Restructuring Shogun's statistical hypothesis testing framework.
 * Copyright (C) 2016  Soumyajit De
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <shogun/statistical_testing/OneDistributionTest.h>
#include <shogun/statistical_testing/internals/DataManager.h>
#include <shogun/statistical_testing/internals/TestTypes.h>

using namespace shogun;
using namespace internal;

COneDistributionTest::COneDistributionTest() : CHypothesisTest(OneDistributionTest::num_feats)
{
}

COneDistributionTest::~COneDistributionTest()
{
}

void COneDistributionTest::set_samples(CFeatures* samples)
{
	auto& data_mgr=get_data_mgr();
	data_mgr.samples_at(0)=samples;
}

CFeatures* COneDistributionTest::get_samples() const
{
	const auto& data_mgr=get_data_mgr();
	return data_mgr.samples_at(0);
}

void COneDistributionTest::set_num_samples(index_t num_samples)
{
	auto& data_mgr=get_data_mgr();
	data_mgr.num_samples_at(0)=num_samples;
}

index_t COneDistributionTest::get_num_samples() const
{
	const auto& data_mgr=get_data_mgr();
	return data_mgr.num_samples_at(0);
}

const char* COneDistributionTest::get_name() const
{
	return "OneDistributionTest";
}
