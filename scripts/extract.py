import argparse
import requests
import sys
import os
import pandas as pd
from datetime import datetime
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common.utils.source_extractors import MetadonneesApiExtractor
from common.config import load_config

def parse_args():
    parser = argparse.ArgumentParser(description='Extract data from configured sources')
    parser.add_argument('--domain', default='rte', help='Extract data for specific domain only')
    parser.add_argument('--config', default='datasources.yaml', help='Path to datasources config file')
    return parser.parse_args()

def get_source_extractor(source_type):
    # This can be expanded based on supported source types
    extractors = {
        'metadonnees_api': MetadonneesApiExtractor,
    }
    return extractors.get(source_type)

def extract_data(config, domain):
    """
    Récupère des données pour une config, un domain, une date
    """
    if config['domains'][domain]:
        sources = config['domains'][domain]['sources']
        if not sources:
            print(f"No sources found for domain: {domain}")
            return
    
    for source in sources:
        source_name = source.get('name')
        source_url = source.get('url')
        print(f"Extracting source: {domain}/{source_name} at URL : {source_url}")
        
        source_type = source['type']
        if not source_type:
            print(f"Source type not specified for {source_name}, skipping...")
            continue

        params = source.get('params', {})
        print(f"Extracting params: {params}")
        if not params:
            print(f"Params not specified for {source_name}")
            # continue

        headers = source.get('headers')
        print(f"Extracting headers: {headers}")
        if not headers:
            print(f"Headers not specified for {source_name}")
            # continue

        response_path = source.get("response_path")
        print(f"Extracting path: {response_path}")
        if not response_path:
            print(f"path not specified for {source_name}")
        
        extractor_class = get_source_extractor(source_type)
        print(f"Getting extractor for source_type: {source_type}")
        if not extractor_class:
            print(f"No extractor implemented for source type: {source_type}")
            continue
            
        try:
            extractor = extractor_class()
            filepath = extractor.download(domain, source)
            print(f"Data extracted from {source_name} and saved to {filepath}")
        except Exception as e:
            print(f"Error extracting data from {source_name}: {str(e)}")

# Test manuel
if __name__ == "__main__":
    # Précise les arguments à utiliser (optionnel si arguments par défaut spécifiés)
    args = parse_args()

    try:
        config = load_config(args.config)
    except Exception as e:
        print(f"Error loading config file: {str(e)}")
        sys.exit(1)
    
    extract_data(config, args.domain)
