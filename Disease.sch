<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <!-- 
    This file contains just the constraints for the profile Condition
    It includes the base constraints for the resource as well.
    Because of the way that schematrons and containment work, 
    you may need to use this schematron fragment to build a, 
    single schematron that validates contained resources (if you have any) 
  -->
  <sch:pattern>
    <sch:title>f:Condition</sch:title>
    <sch:rule context="f:Condition">
      <sch:assert test="count(f:extension[@url = 'http://ga4gh.org/fhir/phenopackets/StructureDefinition/disease-onset']) &lt;= 1">extension with URL = 'http://ga4gh.org/fhir/phenopackets/StructureDefinition/disease-onset': maximum cardinality of 'extension' is 1</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>Condition</sch:title>
    <sch:rule context="f:Condition">
      <sch:assert test="not(parent::f:contained and f:contained)">If the resource is contained in another resource, it SHALL NOT contain nested Resources (inherited)</sch:assert>
      <sch:assert test="not(exists(f:contained/*/f:meta/f:versionId)) and not(exists(f:contained/*/f:meta/f:lastUpdated))">If a resource is contained in another resource, it SHALL NOT have a meta.versionId or a meta.lastUpdated (inherited)</sch:assert>
      <sch:assert test="not(exists(for $contained in f:contained return $contained[not(parent::*/descendant::f:reference/@value=concat('#', $contained/*/id/@value) or descendant::f:reference[@value='#'])]))">If the resource is contained in another resource, it SHALL be referred to from elsewhere in the resource or SHALL refer to the containing resource (inherited)</sch:assert>
      <sch:assert test="exists(f:text/h:div)">A resource should have narrative for robust management (inherited)</sch:assert>
      <sch:assert test="not(exists(f:contained/*/f:meta/f:security))">If a resource is contained in another resource, it SHALL NOT have a security label (inherited)</sch:assert>
      <sch:assert test="not(exists(f:verificationStatus/f:coding[f:system/@value='http://terminology.hl7.org/CodeSystem/condition-ver-status' and f:code/@value='entered-in-error'])) or not(exists(f:clinicalStatus))">Condition.clinicalStatus SHALL NOT be present if verification Status is entered-in-error (inherited)</sch:assert>
      <sch:assert test="not(exists(*[starts-with(local-name(.), 'abatement')])) or exists(f:clinicalStatus/f:coding[f:system/@value='http://terminology.hl7.org/CodeSystem/condition-clinical' and f:code/@value=('resolved', 'remission', 'inactive')])">If condition is abated, then clinicalStatus must be either inactive, resolved, or remission (inherited)</sch:assert>
      <sch:assert test="exists(f:clinicalStatus) or f:verificationStatus/@value='entered-in-error' or not(exists(category[@value='problem-list-item']))">Condition.clinicalStatus SHALL be present if verificationStatus is not entered-in-error and category is problem-list-item (inherited)</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>Condition.extension</sch:title>
    <sch:rule context="f:Condition/f:extension">
      <sch:assert test="@value|f:*|h:div">All FHIR elements must have a @value or children (inherited)</sch:assert>
      <sch:assert test="exists(f:extension)!=exists(f:*[starts-with(local-name(.), 'value')])">Must have either extensions or value[x], not both (inherited)</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>Condition.stage</sch:title>
    <sch:rule context="f:Condition/f:stage">
      <sch:assert test="@value|f:*|h:div">All FHIR elements must have a @value or children (inherited)</sch:assert>
      <sch:assert test="exists(f:summary) or exists(f:assessment)">Stage SHALL have summary or assessment (inherited)</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>Condition.evidence</sch:title>
    <sch:rule context="f:Condition/f:evidence">
      <sch:assert test="@value|f:*|h:div">All FHIR elements must have a @value or children (inherited)</sch:assert>
      <sch:assert test="exists(f:code) or exists(f:detail)">evidence SHALL have code or details (inherited)</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
